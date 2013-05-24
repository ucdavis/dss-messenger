class ApplicationController < ActionController::Base
  include Authentication
  
  before_filter :authenticate
  
  protect_from_forgery
end
