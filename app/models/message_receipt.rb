class MessageReceipt < ApplicationRecord
  belongs_to :message_log
  delegate :message, to: :message_log
end
