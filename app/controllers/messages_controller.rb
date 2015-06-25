class MessagesController < ApplicationController
  filter_access_to [:show, :update, :destroy], :attribute_check => true
  filter_access_to [:index, :create, :open], :attribute_check => false

  def index
    @messages = Message.includes(:recipients,:classification,:modifier,:impacted_services)
      .order('messages.created_at DESC')
      .by_classification(params[:cl])
      .by_modifier(params[:mo])
      .by_service(params[:is])
      .page(params[:page]).per(20) #paginate with 'page' param being the page number, and 20 as the items per page

    @classifications = Classification.all
    @modifiers = Modifier.all
    @impacted_services = ImpactedService.all
    @settings = Setting.all
    @publishers = Publisher.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @messages.to_json(pages: @messages.total_pages, current: @messages.current_page) }
    end
  end

  def show
    @message = Message.find(params[:id])

    # Add colons if necessary
    @message.classification.description = @message.classification.description + ":"  unless @message.classification.description.include? ":"
    @message.modifier.description = @message.modifier.description + ":"  unless @message.modifier.description.include? ":"

    respond_to do |format|
      format.html {render layout: 'public' }
    end
  end

  def create
    # Include distribution channels through which to send messages in model
    @message = Message.new(params[:message])
    @message.sender_uid = Person.find(session[:cas_user]).id #get the full name of the currently logged in user.

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
          ml = MessageLog.find_or_create_by_message_id_and_publisher_id(@message.id, publisher_id)
          ml.send_status = :queued
          ml.save!
          
          Delayed::Job.enqueue(DelayedRake.new("message:publish[#{ml.id}]"))
          Rails.logger.info "Enqueued new message ##{@message.id} for sending via #{Publisher.find(publisher_id).name}. message:publish:[#{ml.id}] should pick it up."
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
    @message = Message.find(params[:id])

    respond_to do |format|
      if @message.update_attributes(params[:message])
        format.html { redirect_to @message, notice: 'Message was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @message = Message.find(params[:id])
    @message.destroy

    respond_to do |format|
      format.html { redirect_to messages_url }
      format.json { head :no_content }
    end
  end

  def open
    @open_messages = Publisher.where(class_name: 'RSSPublisher').first.messages.order('created_at DESC').take(20)

    respond_to do |format|
      format.html { render layout: 'public' } # open.html.erb
      format.rss { render layout: false }     # open.rss.builder
    end
  end
end
