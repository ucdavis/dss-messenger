class RSSPublisher < Publisher
  # RSS Publisher doesn't actually do anything. The controller action that
  # displays the RSS feed only shows messages that have an RSS publisher
  # attached.
  def self.schedule(message_log, message, recipient_list)
    message_log.send_status = :completed
    message_log.save!
  end
end

