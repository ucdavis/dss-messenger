class DssMailer < ActionMailer::Base
  default :from => "DSS IT Service Center <noreply@dss.ucdavis.edu>"
  
  def deliver_message(subject, message, member, footer)
    @message = message
    @footer = footer
    
    mail(:to => "#{member.name} <#{member.email}>", :subject => subject)
  end
end
