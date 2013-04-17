class Broadcast < ActiveRecord::Base
  attr_accessible :messenger_event_id, :message_id
  belongs_to :message
  belongs_to :messenger_event
end
