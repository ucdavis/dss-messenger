class DssMailer < ActionMailer::Base
  default :from => "DSS IT Service Center <noreply@dss.ucdavis.edu>"
  
  def deliver_message(subject, message, message_receipt_id, member, footer)
    @message = message
    @footer = footer
    @mle_id = message_receipt_id
    @hostname = ""

    mail(:to => "#{member.name} <#{member.email}>", :subject => subject)
  end
end
