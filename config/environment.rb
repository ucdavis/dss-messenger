# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
DssMessenger::Application.initialize!

# Configure the CAS server
CASClient::Frameworks::Rails::Filter.configure(
  :cas_base_url => "https://cas.ucdavis.edu/cas/"
)