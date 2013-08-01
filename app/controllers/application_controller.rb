class ApplicationController < ActionController::Base
  include Authentication
  
  before_filter :authenticate
  
  protect_from_forgery
  
  def logout
      CASClient::Frameworks::Rails::Filter.logout(self)
  end
end
