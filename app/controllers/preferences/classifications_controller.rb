class Preferences::ClassificationsController < ApplicationController
  before_action :set_classification, only: [:show, :edit, :update, :destroy]

  #filter_access_to :all

  def index
    @classifications = Classification.all

    render layout: 'preferences'
  end

  def create
    @classification = Classification.new(classification_params)

    respond_to do |format|
      if @classification.save
        format.html { redirect_to preferences_classifications_url, notice: 'Classification was successfully created.' }
        format.json { render json: @classification, status: :created, location: @classification }
      else
        format.html { render action: "new" }
        format.json { render json: @classification.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @classification.update_attributes(classification_params)
        format.html { redirect_to preferences_classifications_url, notice: 'Classification was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @classification.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @classification.destroy

    respond_to do |format|
      format.html { redirect_to preferences_classifications_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_classification
      @classification = Classification.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def classification_params
      params.require(:classification).permit(:description)
    end
end
