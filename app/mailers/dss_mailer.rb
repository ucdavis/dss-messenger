class DssMailer < ActionMailer::Base
  default :from => "DSS IT Service Center <ithelp@dss.ucdavis.edu>"
  
  def deliver_message(message,member)
    @message = message
    @member = member
    @footer = Setting.where(:item_name => 'footer').first.item_value
    @sender = Person.find(message.sender_uid)
    modifier = @message.modifier.description.slice(0..(@message.modifier.description.index(':'))) if @message.modifier
    classification = @message.classification.description.slice(0..(@message.classification.description.index(':'))) if @message.classification
    subject = "#{modifier} #{classification} #{@message.subject}"
    # mail(:to => "#{@member.name} <#{@member.email}>", :subject => subject)
    mail(:from => "#{@from_name} <#{@from_email}>", :to => "#{@member.name} <#{@member.email}>", :subject => subject)
  end
end
