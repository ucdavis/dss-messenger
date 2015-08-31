# Sends e-mails via +DssMailer+.
class DssMailerPublisher < Publisher
  # Constructs the necessary parts of the e-mail and sends it via +DssMailer+.
  def self.publish(message_receipt_id, message, recipient)
    Rails.logger.debug "DssMailer is publishing for message receipt ##{message_receipt_id} ..."


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

    DssMailer.deliver_message(subject, message, message_receipt_id, recipient, footer).deliver_now
    
    receipt = MessageReceipt.find_by(id: message_receipt_id)
    receipt.performed_at = Time.now
    receipt.save!
  end

  # Keeps track of how many people have viewed their e-mails, assuming their
  # e-mail viewer can request images. Sends a pixel-sized gif as a reply.
  def self.callback(message_receipt_id, scope)
    receipt = MessageReceipt.find_by(id: message_receipt_id)

    # Keeping viewed_count as a column because it can be used as a hit counter
    # for RSS, AggieFeed, and other services
    receipt.message_log.viewed_count += 1  unless receipt.viewed
    receipt.message_log.save!

    receipt.viewed = true
    receipt.save!

    scope.send_file Rails.root.join("app/assets/images/1x1.gif"), :type => 'image/gif', :diposition => 'inline'
    scope.headers['Content-Disposition'] = "inline; filename=\"pixel.gif\""
  end
end
