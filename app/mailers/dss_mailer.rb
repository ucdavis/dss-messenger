class DssMailer < ActionMailer::Base
  default :from => "okadri@ucdavis.edu"
  
  def deliver_message(message)
    @message = message
    mail(:to => "#{message.sender_uid} <#{message.sender_uid}@ucdavis.edu>", :subject => @message.subject)
  end
end
