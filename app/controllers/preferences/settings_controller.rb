class Preferences::SettingsController < ApplicationController
  before_action :set_setting, only: [:show, :edit, :update, :destroy]

  def index
    @settings = Setting.all

    render layout: 'preferences'
  end

  def update
    respond_to do |format|
      if @setting.update_attributes(setting_params)
        format.html { redirect_to preferences_settings_url, notice: 'Setting was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @setting.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_setting
      @setting = Setting.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def setting_params
      params.require(:setting).permit(:item_name, :item_value)
    end
end
