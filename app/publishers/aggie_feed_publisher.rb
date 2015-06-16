class AggieFeedPublisher < Publisher
  def self.publish(message_receipt_id, message, recipient)
    aggie_feed_message = AggieFeed.new()
    aggie_feed_message.create(message.subject, message.impact_statement, "", recipient)
  end
end

