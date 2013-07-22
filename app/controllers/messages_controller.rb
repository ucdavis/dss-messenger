class MessagesController < ApplicationController
  # GET /messages
  # GET /messages.json
  def index
    @messages = Message
      .order('created_at DESC')
      .by_classification(params[:cl])
      .by_modifier(params[:mo])
      .by_service(params[:is])
      .by_mevent(params[:me])
      .page(params[:page]).per(20) #paginate with 'page' param being the page number, and 20 as the items per page
    @classifications = Classification.all
    @modifiers = Modifier.all
    @impacted_services = ImpactedService.all
    @messenger_events = MessengerEvent.all
    @rssMessages = Message.by_mevent(2)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @messages.to_json(pages: @messages.total_pages, current: @messages.current_page) }
      format.rss { render layout: false } #index.rss.builder
    end
  end

  # GET /messages/1
  # GET /messages/1.json
  def show
    @message = Message.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @message }
    end
  end

  # GET /messages/new
  # GET /messages/new.json
  def new
    @message = Message.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @message }
    end
  end

  # GET /messages/1/edit
  def edit
    @message = Message.find(params[:id])
  end

  # POST /messages
  # POST /messages.json
  def create
    @message = Message.new(params[:message])
    @message.sender_uid = session[:cas_user] #get the uid of the currently logged in user.
    
    respond_to do |format|
      if @message.save
        format.html { redirect_to @message, notice: 'Message was successfully created.' }
        format.json { render json: @message, status: :created, location: @message }
        @message.delay.send_mass_email if @message.messenger_event_ids.include? 1 # 1=send email?
      else
        format.html { render action: "new" }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /messages/1
  # PUT /messages/1.json
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

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    @message = Message.find(params[:id])
    @message.destroy

    respond_to do |format|
      format.html { redirect_to messages_url }
      format.json { head :no_content }
    end
  end
  
end
