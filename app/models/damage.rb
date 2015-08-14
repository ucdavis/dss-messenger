class Damage < ActiveRecord::Base
  #attr_accessible :impacted_service_id, :message_id
  belongs_to :message
  belongs_to :impacted_service
end
