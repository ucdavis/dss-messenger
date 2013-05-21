class DevelopmentMailInterceptor
  def self.delivering_email(message)
    message.subject = "#{@message.classification.description}: #{@message.subject}"
    message.to = "okadri@ucdavis.edu"
  end
end