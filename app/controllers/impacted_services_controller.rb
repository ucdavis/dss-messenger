class ImpactedServicesController < ApplicationController
  # GET /impacted_services
  # GET /impacted_services.json
  def index
    @impacted_services = ImpactedService.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @impacted_services }
    end
  end

  # GET /impacted_services/1
  # GET /impacted_services/1.json
  def show
    @impacted_service = ImpactedService.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @impacted_service }
    end
  end

  # GET /impacted_services/new
  # GET /impacted_services/new.json
  def new
    @impacted_service = ImpactedService.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @impacted_service }
    end
  end

  # GET /impacted_services/1/edit
  def edit
    @impacted_service = ImpactedService.find(params[:id])
  end

  # POST /impacted_services
  # POST /impacted_services.json
  def create
    @impacted_service = ImpactedService.new(params[:impacted_service])

    respond_to do |format|
      if @impacted_service.save
        format.html { redirect_to @impacted_service, notice: 'Impacted service was successfully created.' }
        format.json { render json: @impacted_service, status: :created, location: @impacted_service }
      else
        format.html { render action: "new" }
        format.json { render json: @impacted_service.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /impacted_services/1
  # PUT /impacted_services/1.json
  def update
    @impacted_service = ImpactedService.find(params[:id])

    respond_to do |format|
      if @impacted_service.update_attributes(params[:impacted_service])
        format.html { redirect_to @impacted_service, notice: 'Impacted service was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @impacted_service.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /impacted_services/1
  # DELETE /impacted_services/1.json
  def destroy
    @impacted_service = ImpactedService.find(params[:id])
    @impacted_service.destroy

    respond_to do |format|
      format.html { redirect_to impacted_services_url }
      format.json { head :no_content }
    end
  end
end
