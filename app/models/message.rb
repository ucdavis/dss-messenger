class Message < ActiveRecord::Base
  attr_accessible :impact_statement, :other_services, :purpose, :resolution, :sender_uid, :subject, :window_end, :window_start, :workaround, :recipient_ids, :messenger_event_ids, :impacted_service_ids, :created_at
  has_many :damages
  has_many :impacted_services, :through => :damages
  has_many :broadcasts
  has_many :messenger_events, :through => :broadcasts
  has_many :audiences
  has_many :recipients, :through => :audiences
  
  belongs_to :classification
  belongs_to :modifier
end
