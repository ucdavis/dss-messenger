class MessageLog < ActiveRecord::Base
  STATUSES = [:queued, :sending, :completed, :error]
  
  belongs_to :message
  has_many :entries, :class_name => "MessageLogEntry"
  
  # Enforce pseudo-'enum' behavior for self.send_status
  def send_status
    value = read_attribute(:send_status)
    STATUSES[value] if value
  end
  def send_status= (value)
    i = STATUSES.index(value)
    write_attribute(:send_status, i) if i
  end
end
