class DssMailer < ActionMailer::Base
  default :from => "okadri@ucdavis.edu"
  
  def deliver_message(message)
    @message = message
    @message.recipients.each do |r|
      # Look up e-mail address for r.uid
      @entity = Entity.find(r.uid)
      if @entity.type == "Group"
        @entity.members.each do |m|
          # Send the e-mail
          @member = Entity.find(m.id)
          mail(:to => "#{@member.name} <#{@member.email}>",
            :subject => "#{@message.classification.description}: #{@message.subject}")
        end
      elsif @entity.type == "Person"
        # Send the e-mail
        @member = @entity
        mail(:to => "#{@member.name} <#{@member.email}>",
          :subject => "#{@message.classification.description}: #{@message.subject}")
      end
    end
  end
end
