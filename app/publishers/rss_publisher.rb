# +RSSPublisher+ doesn't actually do anything. The controller action that
# displays the RSS feed only shows messages that have an RSS publisher
# attached.
class RSSPublisher < Publisher
  # Modifies +message_log+ to say that sending is completed.
  def self.schedule(message_log, recipient_list)
    message_log.send_status = :completed
    message_log.save!
  end
end
