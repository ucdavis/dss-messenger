class DssMailer < ActionMailer::Base
  default :from => "dss-notify@ucdavis.edu"
  
  def deliver_message(message,member)
    @message = message
    @member = member
    modifier = @message.modifier.description.slice(0..(@message.modifier.description.index(':'))) if @message.modifier
    classification = @message.classification.description.slice(0..(@message.classification.description.index(':'))) if @message.classification
    subject = "#{modifier} #{classification} #{@message.subject}"
    mail(:to => "#{@member.name} <#{@member.email}>", :subject => subject)
  end
end
