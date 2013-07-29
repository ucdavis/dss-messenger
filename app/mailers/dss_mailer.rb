class DssMailer < ActionMailer::Base
  default :from => "dss-notify@ucdavis.edu"
  
  def deliver_message(message,member)
    @message = message
    @member = member
    @sender = Person.find(message.sender_uid)
    modifier = @message.modifier.description.slice(0..(@message.modifier.description.index(':'))) if @message.modifier
    classification = @message.classification.description.slice(0..(@message.classification.description.index(':'))) if @message.classification
    subject = "#{modifier} #{classification} #{@message.subject}"
    mail(:from => "#{@sender.name} <#{@sender.email}>", :to => "#{@member.name} <#{@member.email}>", :subject => subject)
  end
end
