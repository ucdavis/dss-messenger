class DevelopmentMailInterceptor
  def self.delivering_email(message)
    message.subject = "#{message.subject}"
    message.to = "okadri@ucdavis.edu"
  end
end