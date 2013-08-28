# Credit: http://trevorturk.com/2011/02/25/logging-outgoing-emails-in-rails-3/

class EmailLogger
  def self.delivered_email(email)
    Rails.logger.tagged("email") { Rails.logger.info "Message sent from '#{email.from}' to '#{email.to}' with subject '#{email.subject}'" }
  end
end
 
Mail.register_observer(EmailLogger)
