class AggieFeedPublisher < Publisher
  def self.publish(message_receipt_id, message, recipient)
    aggie_feed_message = AggieFeed.new()
    aggie_feed_message.create(message_receipt_id, message.subject, message.impact_statement, "", recipient)
  end
  def self.callback(message_receipt_id, scope)
    receipt = MessageReceipt.find_by_id(message_receipt_id)

    receipt.message_log.viewed_count += 1
    receipt.message_log.save!

    super
  end
end

