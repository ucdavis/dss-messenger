class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :edit, :update, :destroy]

  filter_access_to [:show, :update, :destroy], :attribute_check => true
  filter_access_to [:index, :create, :open], :attribute_check => false

  def index
    @display_archived = (params[:display] and params[:display] == 'archived') ? true : false

    @messages = Message.where(:closed => @display_archived).order('messages.created_at DESC')

    @modifiers = Modifier.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @messages.to_json(pages: @messages.total_pages, current: @messages.current_page) }
    end
  end

  def show
    # Add colons if necessary
    if @message.classification
      # classification is not required
      @message.classification.description = @message.classification.description + ":"  unless @message.classification.description.include? ":"
    end
    if @message.modifier
      # modifier is not required
      @message.modifier.description = @message.modifier.description + ":"  unless @message.modifier.description.include? ":"
    end

    respond_to do |format|
      format.html
    end
  end

  def create
    # Include distribution channels through which to send messages in model
    @message = Message.new(message_params)
    @message.sender_uid = Person.find(session[:cas_user]).id # get the full name of the currently logged in user

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

        format.html { redirect_to @message, notice: 'Message was successfully created.' }
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
        format.html { redirect_to @message, notice: 'Message was successfully updated.' }
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
      format.html { redirect_to messages_url }
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      params.require(:message).permit(:impact_statement, :other_services, :purpose, :resolution, :sender_uid, :subject, :window_end, :window_start, :workaround, :classification_id, :modifier_id, :recipient_uids, :impacted_service_ids, :closed, :publisher_ids => [])
    end
end
