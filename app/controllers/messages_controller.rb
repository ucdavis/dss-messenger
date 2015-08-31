class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :edit, :update, :destroy, :archive, :duplicate, :reactivate]

  filter_access_to [:show, :update, :destroy], :attribute_check => true
  filter_access_to [:index, :create, :open], :attribute_check => false

  def index
    @display_archived = (params[:display] and params[:display] == 'archived') ? true : false

    if params[:q]
      messages_table = Message.arel_table

      @messages = Message.where(
        messages_table[:subject].matches("%#{params[:q]}%")
        .or(messages_table[:impact_statement].matches("%#{params[:q]}%"))
        .or(messages_table[:purpose].matches("%#{params[:q]}%"))
        .or(messages_table[:resolution].matches("%#{params[:q]}%"))
        .or(messages_table[:workaround].matches("%#{params[:q]}%"))
        .or(messages_table[:other_services].matches("%#{params[:q]}%"))
      )
    else
      @messages = Message.where(:closed => @display_archived).order('messages.created_at DESC')
    end

    @modifiers = Modifier.all
  end

  def show
    # Determine the number of sent/unsent as well as read/unread
    # Note: This calculation is only valid if they're using the E-Mail publisher
    email_log = @message.logs.find{ |l| l.publisher.class_name = "DssMailerPublisher"}

    # Our charts only show percentages so, in the case of an unknown number of
    # recipients, we can get away with, e.g. a read percentage of "0 / 1"
    @sent = 0
    @unsent = 1
    @read = 0
    @unread = 1

    if email_log
      # :queued (ignore), :error (?)
      if (email_log.status == :sending) || (email_log.status == :completed)
        @read = email_log.viewed_count
        @unread = email_log.recipient_count - @read
        @sent = email_log.entries.length
        @unsent = email_log.recipient_count - @sent
      end
    end

    if params[:tab] == 'recipients'
      if email_log
        @recipients = email_log.entries.map{ |e| { name: e.recipient_name, email: e.recipient_email } }
      else
        @recipients = []
      end
    else
      # Calculate the e-mail footer for the message preview section
      @footer = Setting.where(:item_name => 'footer').first
      if @footer
        @footer = @footer.item_value
      else
        @footer = ""
      end
    end
  end

  def new
    @message = Message.new
  end

  def create
    # Recipients comes in as a JSON string, so convert it. (model has
    # added recipients= support)
    params[:message][:recipients] = JSON.parse(params[:message][:recipients])

    # Include distribution channels through which to send messages in model
    @message = Message.new(message_params)
    @message.sender = Person.find(session[:cas_user]).name

    # The message is open or closed depending on the selected modifier
    unless @message.modifier.nil?
      if @message.modifier.open_ended
        @message.closed = false
      else
        @message.closed = true
      end
    end

    respond_to do |format|
      if @message.save
        # The following two lines are required for Delayed::Job.enqueue to work from a controller
        require 'rake'
        load File.join(Rails.root, 'lib', 'tasks', 'bulk_send.rake')

        params[:message][:publisher_ids].each do |publisher_id|
          ml = MessageLog.find_or_create_by(message_id: @message.id, publisher_id: publisher_id)
          ml.status = :queued
          ml.save!

          Delayed::Job.enqueue(DelayedRake.new("message:publish[#{ml.id}]"))
          Rails.logger.info "Enqueued new message ##{@message.id} for sending via #{Publisher.find(publisher_id).name}. message:publish[#{ml.id}] should pick it up."
        end

        format.html { redirect_to messages_path(:display => 'active'), notice: 'Message was successfully queued.' }
        format.json { render json: @message, status: :created, location: @message }
      else
        format.html { render action: "new" }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @message.update_attributes(message_params)
        format.html { redirect_to @message, notice: 'Message successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @message.destroy

    respond_to do |format|
      format.html { redirect_to messages_url(display: 'archived'), notice: 'Message successfully deleted.' }
      format.json { head :no_content }
    end
  end

  def open
    rss_publisher = Publisher.where(class_name: 'RSSPublisher').first

    # Return a blank Message object for the view to use when nothing has been
    # published to RSS. In Rails 4, the proper way to do this would be
    # Message.none (to get an ActiveRecord::NullRelation), but there's no good
    # way to do this (that I found) in Rails 3.
    @open_messages = ((rss_publisher.nil? and Message.where('1 = 2')) or
                       rss_publisher.messages.order('created_at DESC').take(20))

    respond_to do |format|
      format.html { render layout: 'public' } # open.html.erb
      format.rss { render layout: false }     # open.rss.builder
    end
  end

  # archive (and re-activate) merely toggle the 'closed' flag on a message
  def archive
    @message.closed = true

    if @message.save
      redirect_to messages_path, notice: 'Message was successfully archived.'
    else
      raise "Error while archiving message ##{@message.id}."
    end
  end

  def reactivate
    @message.closed = false

    if @message.save
      redirect_to messages_path, notice: 'Message was successfully re-activated.'
    else
      raise "Error while re-activating message ##{@message.id}."
    end
  end

  # 'duplicate' is essentially 'new' but we fill in many fields based on the
  # elder message being duplicated.
  def duplicate
    original_message = @message

    @message = @message.dup

    # .dup does not handle associations currently
    @message.recipient_ids = original_message.recipient_ids
    @message.impacted_service_ids = original_message.impacted_service_ids
    @message.publisher_ids = original_message.publisher_ids

    # duplicate may be given a modifier via params
    @message.modifier_id = params[:modifier] if params[:modifier]

    render 'new'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id]) if params[:id]
      @message = Message.find(params[:message_id]) unless @message
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      params.require(:message).permit(:impact_statement, :other_services, :purpose, :resolution, :sender_uid, :subject, :window_end, :window_start, :workaround, :classification_id, :modifier_id, :closed, :impacted_service_ids => [], :publisher_ids => [], :recipients => [:uid, :name])
    end
end
