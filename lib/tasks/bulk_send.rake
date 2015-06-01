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

      # Add a colon to the modifier and classification if one doesn't exist
      # already.
      modifier = message.modifier.description + ":" if message.modifier
      classification = message.classification.description + ":" if message.classification

      # Construct the subject
      modifier = modifier.slice(0..(modifier.index(':')))+" " if message.modifier
      classification = classification.slice(0..(classification.index(':')))+" " if message.classification
      subject = "#{modifier}#{classification}#{message.subject}"

      # Get the footer (if one is set)
      footer = Setting.where(:item_name => 'footer').first
      if footer
        footer = footer.item_value
      else
        footer = "" # set Footer text to empty if unset
      end

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

      unique_members = members.uniq { |p| p.email }

      # Deliver message via AggieFeed
      aggie_feed_mesg = Activity.new
      aggie_feed_mesg.title = subject
      aggie_feed_mesg.object = {
        content: message.impact_statement,
        ucdEdusModel: {
          urlDisplayName: "View Message"
        }
      }
      # TODO: Figure out how to use kerberos loginid instead of email. Entity
      # only has email, name, and type as attributes.
      aggie_feed_mesg.to = unique_members.map { |m| { id: m.email, g: false, i: false } }
      aggie_feed_mesg.save

      # Deliver the message (via e-mail) to each recipient
      # unique_members = members.uniq { |p| p.email }
      unique_members.each do |m|
        DssMailer.delay.deliver_message(subject, message, ml, OpenStruct.new(:name => m.name, :email => m.email), footer)
      end

      Rails.logger.info "Enqueueing message ##{args.message_id} for #{members.length} recipients took #{Time.now - timestamp_start} seconds"
    end
  end
end
