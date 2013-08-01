class MessengerEventsController < ApplicationController
  filter_resource_access
  
  # GET /events
  # GET /events.json
  def index
    @messenger_events = MessengerEvent.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @messenger_events }
    end
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @messenger_event = MessengerEvent.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @messenger_events }
    end
  end

  # GET /events/new
  # GET /events/new.json
  def new
    @messenger_event = MessengerEvent.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @messenger_events }
    end
  end

  # GET /events/1/edit
  def edit
    @messenger_event = MessengerEvent.find(params[:id])
  end

  # POST /messenger_events
  # POST /messenger_events.json
  def create
    @messenger_event = MessengerEvent.new(params[:messenger_event])

    respond_to do |format|
      if @messenger_event.save
        format.html { redirect_to @messenger_event, notice: 'Event was successfully created.' }
        format.json { render json: @messenger_event, status: :created, location: @messenger_event }
      else
        format.html { render action: "new" }
        format.json { render json: @messenger_event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /messenger_events/1
  # PUT /messenger_events/1.json
  def update
    @messenger_event = MessengerEvent.find(params[:id])

    respond_to do |format|
      if @messenger_event.update_attributes(params[:messenger_event])
        format.html { redirect_to @messenger_event, notice: 'Event was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @messenger_event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messenger_events/1
  # DELETE /messenger_events/1.json
  def destroy
    @messenger_event = MessengerEvent.find(params[:id])
    @messenger_event.destroy

    respond_to do |format|
      format.html { redirect_to messenger_events_url }
      format.json { head :no_content }
    end
  end
end
