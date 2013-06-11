class ApplicationController < ActionController::Base
  include Authentication
  
  before_filter :authenticate
  
  filter_resource_access
  
  protect_from_forgery
end
