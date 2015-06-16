class MessageLog < ActiveRecord::Base
  STATUSES = [:queued, :sending, :completed, :error]
  
  belongs_to :message
  belongs_to :publisher
  has_many :entries, :class_name => "MessageReceipt"
  
  # Enforce pseudo-'enum' behavior for self.send_status
  def send_status
    value = read_attribute(:status)
    STATUSES[value] if value
  end
  def send_status= (value)
    i = STATUSES.index(value)
    write_attribute(:status, i) if i
  end
end
