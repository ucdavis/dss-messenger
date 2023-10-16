class Preferences::ImpactedServicesController < ApplicationController
  before_action :set_impacted_service, only: [:show, :edit, :update, :destroy]

  #filter_access_to :all

  def index
    @impacted_services = ImpactedService.all

    render layout: 'preferences'
  end

  def create
    @impacted_service = ImpactedService.new(impacted_service_params)

    respond_to do |format|
      if @impacted_service.save
        format.html { redirect_to preferences_impacted_services_url, notice: 'Impacted service was successfully created.' }
        format.json { render json: @impacted_service, status: :created, location: @impacted_service }
      else
        format.html { render action: "new" }
        format.json { render json: @impacted_service.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @impacted_service.update(impacted_service_params)
        format.html { redirect_to preferences_impacted_services_url, notice: 'Impacted service was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @impacted_service.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @impacted_service.destroy

    respond_to do |format|
      format.html { redirect_to preferences_impacted_services_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_impacted_service
      @impacted_service = ImpactedService.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def impacted_service_params
      params.require(:impacted_service).permit(:name)
    end
end
