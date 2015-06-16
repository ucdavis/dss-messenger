class PublishersController < ApplicationController
  filter_resource_access

  def index
    @publishers = Publisher.all

    respond_to do |format|
      format.html
      format.json { render json: @publishers }
    end
  end
end
