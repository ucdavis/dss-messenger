require 'rack/cas'

Rails.application.config.middleware.use(
  Rack::CAS,
  server_url: ENV.fetch("CAS_URL")
)