class Damage < ApplicationRecord
  belongs_to :message
  belongs_to :impacted_service
end
