require 'rake'

namespace :message do
  desc 'Send a message'
  task :send, [:message_id] => :environment do |t, args|
    Rails.logger.tagged('task:message:send') do
      message = Message.find_by_id(args.message_id)

      unless message
        Rails.logger.error "Unable to find message with ID #{args.message_id}"
        next # used in rake to abort a rake task (as well as in loops)
      end
      
      # Construct the subject
      modifier = message.modifier.description.slice(0..(message.modifier.description.index(':')))+" " if message.modifier
      classification = message.classification.description.slice(0..(message.classification.description.index(':')))+" " if message.classification
      subject = "#{modifier}#{classification}#{message.subject}"
      
      # Get the footer
      footer = Setting.where(:item_name => 'footer').first.item_value
    
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
        DssMailer.delay.deliver_message(subject, message, OpenStruct.new(:name => m.name, :email => m.email), footer)
      end
      
      Rails.logger.info "Enqueueing message ##{args.message_id} for #{members.length} recipients took #{Time.now - timestamp_start} seconds"
    end
  end
end
