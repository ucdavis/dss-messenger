ActionMailer::Base.smtp_settings = {
  :address              => "smtp.ucdavis.edu",
  :port                 => 587,
  :domain               => "ucdavis.edu",
  :enable_starttls_auto => true
}

ActionMailer::Base.default_url_options[:host] = "localhost:3000"

require 'development_mail_interceptor'
Mail.register_interceptor(DevelopmentMailInterceptor) if Rails.env.development?
