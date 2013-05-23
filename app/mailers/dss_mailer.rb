class DssMailer < ActionMailer::Base
  default :from => "okadri@ucdavis.edu"
  
  def deliver_message(message)
    @message = message
    modifier = @message.modifier.description.slice(0..(@message.modifier.description.index(':'))) if @message.modifier
    classification = @message.classification.description.slice(0..(@message.classification.description.index(':'))) if @message.classification
    subject = "#{modifier} #{classification} #{@message.subject}"
    @message.recipients.each do |r|
      # Look up e-mail address for r.uid
      @entity = Entity.find(r.uid)
      if @entity.type == "Group"
        @entity.members.each do |m|
          # Send the e-mail
          @member = Entity.find(m.id)
          mail(:to => "#{@member.name} <#{@member.email}>",
            :subject => subject)
        end
      elsif @entity.type == "Person"
        # Send the e-mail
        @member = @entity
        mail(:to => "#{@member.name} <#{@member.email}>",
          :subject => subject)
      end
    end
  end
end
