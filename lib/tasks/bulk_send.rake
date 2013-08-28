require 'rake'

namespace :message do
  desc 'Send a message'
  task :send, [:message_id] => :environment do |t, args|
    Rails.logger.tagged('task:message:send') do
      message = Message.find(args.message_id)
    
      unless message
        Rails.logger.error "Unable to find message with ID #{args.message_id}"
        next # used in rake to abort a rake task (as well as in loops)
      end
      
      timestamp_start = Time.now
    
      members = []
    
      # Resolve e-mail addresses for message recipients
      message.recipients.each do |r|
        entity = Entity.find(r.uid)
      
        unless entity
          Rails.logger.warning "Could not find entity with UID #{r.id}"
          next
        end
      
        # If entity is a group, resolve individual group members
        if entity.type == "Group"
          entity.members.map(&:id).uniq.each do |m|
            p = Person.find(m)
          
            unless p
              Rails.logger.warning "Could not find Person with ID #{m}"
              next
            end
          
            members << p
          end
        elsif entity.type == "Person"
          members << entity
        end
      end
    
      # Deliver the message to each recipient
      members.each do |m|
        DssMailer.delay.deliver_message(message, m)
      end
      
      Rails.logger.info "Enqueueing message ##{args.message_id} for #{members.length} recipients took #{Time.now - timestamp_start} seconds"
    end
  end
end
