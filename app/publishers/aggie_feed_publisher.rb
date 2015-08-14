class AggieFeedPublisher < Publisher
  # Dispatches to +AggieFeed.create+ to publish a post via Aggie Feed's API.
  def self.publish(message_receipt_id, message, recipient)
    aggie_feed_message = AggieFeed.new()
    aggie_feed_message.create(message_receipt_id, message.subject, message.impact_statement, "", recipient)
  end

  # Increments the count of number of views this message has received and
  # displays the message.
  # *Note:* Unlike DssMailerPublisher, the count is increased regardless of
  # whether or not the same person has viewed this message multiple times, even
  # though everyone gets a unique URL for each Aggie Feed message.
  def self.callback(message_receipt_id, scope)
    receipt = MessageReceipt.find_by(id: message_receipt_id)

    receipt.message_log.viewed_count += 1
    receipt.message_log.save!

    scope.instance_eval do
      @message = receipt.message

      # Add colons if necessary
      @message.classification.description = @message.classification.description + ":"  unless @message.classification.description.include? ":"
      @message.modifier.description = @message.modifier.description + ":"  unless @message.modifier.description.include? ":"

      render 'messages/show'
    end
  end
end
