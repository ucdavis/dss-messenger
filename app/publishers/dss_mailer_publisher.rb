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
end
