# A MessageLog object should exist for each message+publisher combination.
# For example, a message only sent via e-mail will have a single MessageLog.
# Another message sent via e-mail and AggieFeed will have two MessageLog objects.
# Each MessageLog object tracks its own unique send receipts.
# MessageLog 'entries' may not be correctly filled in while status is 'queued'
# as the background bulk_send task still needs to set up the data.
class MessageLog < ApplicationRecord
  STATUSES = [:queued, :sending, :completed, :error]

  belongs_to :message
  belongs_to :publisher

  # Enforce pseudo-'enum' behavior for self.status
  def status
    value = read_attribute(:status)
    STATUSES[value] if value
  end

  def status=(value)
    i = STATUSES.index(value)
    write_attribute(:status, i) if i
  end

  def entries(only_performed = false)
    entries = MessageReceipt.find_by_message_log_id(id)

    entries&.select! { |e| e.performed_at.present? } if only_performed

    return entries || []
  end
end
