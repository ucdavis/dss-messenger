class ApplicationController < ActionController::Base
  include Authentication
  
  before_filter :authenticate, :except => [:open, :show, :status]
  
  protect_from_forgery
  
  def logout
      CASClient::Frameworks::Rails::Filter.logout(self)
  end

  def status
    render :json => { status: 'ok' }, :status => :ok
  end
end
