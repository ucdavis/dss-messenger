class PublishersController < ApplicationController
  before_action :set_publisher, only: [:show, :edit, :update, :destroy]

  filter_access_to :all

  def index
    @publishers = Publisher.all

    respond_to do |format|
      format.html
      format.json { render json: @publishers }
    end
  end

  def update
    respond_to do |format|
      if @publisher.update_attributes(publisher_params)
        format.json { head :no_content }
      else
        format.json { render json: @publisher.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_publisher
      @publisher = Publisher.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def publisher_params
      params.require(:publisher).permit(:class_name, :default, :name)
    end
end
