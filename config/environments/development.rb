DssMessenger::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Only use best-standards-support built into browsers
  config.action_dispatch.best_standards_support = :builtin

  # Expands the lines which load the assets
  config.assets.debug = true

  config.eager_load = false

  ActionMailer::Base.delivery_method = :file

  # #SMTP Settings
  # ActionMailer::Base.smtp_settings = {
  #   :address              => "smtp.ucdavis.edu",
  #   :port                 => 587,
  #   :domain               => "dss.ucdavis.edu",
  #   :enable_starttls_auto => true
  # }
  #
  # require 'development_mail_interceptor'
  # Mail.register_interceptor(DevelopmentMailInterceptor) if Rails.env.development?

  config.host_url = 'localhost:3000'

  # Set default url for ActionMailer
  config.action_mailer.default_url_options = { :host => "localhost:3000" }
end
