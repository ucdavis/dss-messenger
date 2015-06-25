class PublishersController < ApplicationController
  filter_resource_access

  def index
    @publishers = Publisher.all

    respond_to do |format|
      format.html
      format.json { render json: @publishers }
    end
  end

  def update
    @publisher = Publisher.find(params[:id])

    respond_to do |format|
      if @publisher.update_attributes(params[:publishers])
        format.json { head :no_content }
      else
        format.json { render json: @publisher.errors, status: :unprocessable_entity }
      end
    end
  end
end
