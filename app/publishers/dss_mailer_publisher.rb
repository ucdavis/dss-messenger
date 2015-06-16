class DssMailerPublisher < Publisher
  def self.publish(message_receipt_id, message, recipient)
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

    DssMailer.deliver_message(subject, message, message_receipt_id, recipient, footer)
  end

  def self.callback(message_receipt_id) 
    receipt = MessageReceipt.find_by_id(message_receipt_id)

    # Keeping viewed_count as a column because it can be used as a hit counter
    # for RSS, AggieFeed, and other services
    receipt.message_log.viewed_count += 1  unless message_entry.viewed
    receipt.message_log.save!

    receipt.viewed = true
    receipt.save!

    send_file Rails.root.join("app/assets/images/1x1.gif"), :type => 'image/gif', :diposition => 'inline'
  end
end
