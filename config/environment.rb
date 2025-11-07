# Load the Rails application.
require_relative "application"

require "delayed_rake"

# Initialize the Rails application.
Rails.application.initialize!

# Configure the CAS server
CASClient::Frameworks::Rails::Filter.configure(
  cas_base_url: Rails.application.secrets[:cas_url]
)
