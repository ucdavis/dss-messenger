# Sends e-mails.
class DssMailer < ActionMailer::Base
  default :from => "DSS IT Service Center <noreply@dss.ucdavis.edu>"

  def deliver_message(subject, message, message_receipt_id, member, footer)
    @message = message
    @footer = footer
    @mle_id = message_receipt_id

    begin
      mail(:to => "#{member.name} <#{member.email}>", :subject => subject).deliver
    rescue Net::SMTPFatalError => e
       if e.backtrace.include?('User unknown')
         # Nothing we can do about an incorrect e-mail address ...
         Rails.logger.warn("SMTP returned 'User unknown' for #{member.name} <#{member.email}>")
       elsif e.backtrace.include?('expired account')
         # Nothing we can do about an expired account ...
         Rails.logger.warn("SMTP returned 'expired account' for #{member.name} <#{member.email}>")
       else
         # Not going to handle it after all ...
         raise(e)
       end
    end
  end
end
