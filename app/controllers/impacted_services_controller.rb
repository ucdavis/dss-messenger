class ImpactedServicesController < ApplicationController
  filter_resource_access

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

  def destroy
    @impacted_service = ImpactedService.find(params[:id])
    @impacted_service.destroy

    respond_to do |format|
      format.html { redirect_to impacted_services_url }
      format.json { head :no_content }
    end
  end
end
