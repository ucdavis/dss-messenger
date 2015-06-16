class MessageReceipt < ActiveRecord::Base
  belongs_to :message_log
end
