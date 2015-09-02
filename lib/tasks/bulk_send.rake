require 'rake'

namespace :message do
  desc 'Publish a message'
  task :publish, [:message_log_id] => :environment do |t, args|
    Rails.logger.tagged('task:message:publish') do
      message_log = MessageLog.find_by(id: args.message_log_id)
      unless message_log
        Rails.logger.error "Unable to find message log with ID #{args.message_log_id}"
        next # used in rake to abort a rake task (as well as in loops)
      end

      message = message_log.message
      unless message
        Rails.logger.error "Unable to find message for message log with ID #{message_log.id}"
        next
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
        if entity.type == "Group"
          g = Group.find(entity.id)

          g.members.each do |m|
            p = Person.new

            p.name = m[:name]
            p.email = m[:email]
            p.id = m[:id]

            members << p
          end
        elsif entity.type == "Person"
          members << entity
        end
      end

      message_log.status = :sending
      message_log.start = Time.now
      message_log.recipient_count = members.length
      message_log.save!

      recipient_list = members.uniq { |p| p.email }

      message_log.publisher.classify.schedule(message_log, recipient_list)

      Rails.logger.info "Enqueueing message ##{message.id} for #{members.length} recipients took #{Time.now - timestamp_start} seconds"
    end
  end
end
