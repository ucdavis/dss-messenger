class MessageReceipt < ActiveRecord::Base
  belongs_to :message_log
  delegate :message, :to => :message_log
end
