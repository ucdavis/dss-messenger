class Broadcast < ActiveRecord::Base
  attr_accessible :event_id, :message_id
  belongs_to :message
  belongs_to :event
end
