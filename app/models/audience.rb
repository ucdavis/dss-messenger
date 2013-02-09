class Audience < ActiveRecord::Base
  attr_accessible :message_id, :recipient_id
  belongs_to :message
  belongs_to :recipient
end
