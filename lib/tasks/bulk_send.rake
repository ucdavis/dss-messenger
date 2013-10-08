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
      
      ml = MessageLog.find_or_create_by_message_id(message.id)
      
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
        begin
          entity = Entity.find(r.uid)
        rescue Exception => e
          Rails.logger.error "ActiveResource error while fetching entity with UID #{r.id}: '#{e}'. Skipping to next."
          next
        end
        
        unless entity
          Rails.logger.warning "Could not find entity with UID #{r.id}. Skipping to next."
          next
        end
      
        # If entity is a group, resolve individual group members
        if entity.type == "Group"
          entity.members.map(&:id).uniq.each do |m|
            begin
              p = Person.find(m)
            rescue Exception => e
              Rails.logger.error "ActiveResource error while fetching group member with UID #{m}: '#{e}'. Skipping to next group member."
              next
            end
          
            members << p
          end
        elsif entity.type == "Person"
          members << entity
        end
      end
      
      ml.send_status = :sending
      ml.send_start = Time.now
      ml.recipient_count = members.length
      ml.save!
      
      # Deliver the message to each recipient
      members.each do |m|
        DssMailer.delay.deliver_message(subject, message, ml, OpenStruct.new(:name => m.name, :email => m.email), footer)
      end
      
      Rails.logger.info "Enqueueing message ##{args.message_id} for #{members.length} recipients took #{Time.now - timestamp_start} seconds"
    end
  end
end
