class Broadcast < ApplicationRecord
  belongs_to :message
  belongs_to :messenger_event
end
