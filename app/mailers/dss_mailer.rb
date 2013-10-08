class DssMailer < ActionMailer::Base
  default :from => "DSS IT Service Center <noreply@dss.ucdavis.edu>"
  
  def deliver_message(subject, message, message_log, member, footer)
    @message = message
    @footer = footer
    
    mail(:to => "#{member.name} <#{member.email}>", :subject => subject)
    
    mle = MessageLogEntry.new
    mle.recipient_name = member.name
    mle.recipient_email = member.email
    message_log.entries << mle
    
    if message_log.entries.length == message_log.recipient_count
      message_log.send_status = :completed
      message_log.send_finish = Time.now
      message_log.save!
    end
  end
end
