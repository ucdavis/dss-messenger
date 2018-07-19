class RecipientsController < ApplicationController
  #filter_access_to :all

  def index
    @recipients = Entity.search(params[:q])
  end
end
