require 'rake'

namespace :message do
  desc 'Send the passed message to the recipients'
  task :send, [:message_id] => :environment do |t, args|
    @message = Message.find(args.message_id)
    @message.recipients.each do |r|
      # Look up e-mail address for r.uid
      @entity = Entity.find(r.uid)
      if @entity.type == "Group"
        # get unique memberships of the group
        puts "Sending to group recipient: " + @entity.name
        memberships = @entity.memberships.map(&:entity_id).uniq
        memberships.each do |m|
          # Send the e-mail
          @member = Person.find(m)
          puts " --- Sending to recipient: " + @member.name
          DssMailer.deliver_message(@message,@member).deliver
        end
      elsif @entity.type == "Person"
        # Send the e-mail
        @member = Person.find(r.uid)
        puts "Sending to single recipient: " + @member.name
        DssMailer.deliver_message(@message,@member).deliver
      end
    end
  end
end