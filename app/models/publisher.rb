class Publisher < ActiveRecord::Base
  attr_accessible :class_name, :default, :name

  def self.schedule(message_log, message, recipient_list)
    message_log.send_status = :queued
    message_log.save!

    recipient_list.each do |recipient|
        self.delay.perform(message_log, message, recipient)
    end
  end

  # Makes a message receipt and does the actual publishing/sending of a message.
  def self.perform(message_log, message, recipient)
    receipt = MessageReceipt.new
    receipt.recipient_name = recipient.name
    receipt.recipient_email = recipient.email
    receipt.login_id = recipient.loginid?
    message_log.entries << receipt

    self.publish(receipt.id, message, recipient)

    if message_log.entries.length == message_log.recipient_count
      message_log.send_status = :completed
      message_log.finish = Time.now
      message_log.save!
    else
      message_log.send_status = :sending
      message_log.save!
    end
  end

  def self.publish(message_receipt_id, message, recipient)
  end

  def self.callback(message_receipt_id, scope)
  end
end
