require 'rake'

namespace :message do
  desc 'Auto-archive messages after their close window'
  task auto_archive: :environment do |t, args|
    Message.all.each do |message|
      # If they message isn't closed ...
      unless message.closed
        # and has a defined end window ...
        if message.window_end
          # and the end window is in the past ...
          if message.window_end < Time.now
            # close the message.
            message.closed = true
            message.save!
          end
        end
      end
    end
  end

  desc 'Publish a message'
  task :publish, [:message_log_id] => :environment do |t, args|
    Rails.logger.tagged('task:message:publish') do
      message_log = MessageLog.find_by(id: args.message_log_id)
      unless message_log
        Rails.logger.error "Unable to find message log with ID #{args.message_log_id}"
        raise "Unable to publish message. Message log with ID #{args.message_log_id} missing. See logs."
        exit(-1)
      end

      message = message_log.message
      unless message
        Rails.logger.error "Unable to find message for message log with ID #{message_log.id}"
        raise "Unable to publish message. Message with ID #{message_log.id} is missing for message log with ID #{args.message_log_id}. See logs."
        exit(-1)
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

        # If entity is a group, determine its individual members
        if entity.type == 'Group'
          g = Group.find(entity.id)
          Rails.logger.info "Resolving e-mail addresses for Group with ID #{entity.id} ..."

          g.members.each do |m|
            p = Person.new

            p.name = m[:name]
            p.email = m[:email]
            p.id = m[:id]

            Rails.logger.info "Resolved e-mail address for group member with ID #{p.id} for Group with ID #{entity.id} to #{p.email}"

            members << p
          end
        elsif entity.type == "Person"
          Rails.logger.info "Resolving e-mail address for Person with ID #{entity.id} to #{entity.email} ..."
          members << entity
        end
      end

      message_log.status = :sending
      message_log.start = Time.now
      message_log.recipient_count = members.length
      message_log.save!

      recipient_list = members.uniq { |p| p.email }

      Rails.logger.info "Resolved #{recipient_list.length} unique e-mails to address"

      message_log.publisher.classify.schedule(message_log, recipient_list)

      Rails.logger.info "Enqueueing message ##{message.id} for #{members.length} recipients took #{Time.now - timestamp_start} seconds"
    end
  end
end
