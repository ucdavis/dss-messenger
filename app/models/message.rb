class Message < ActiveRecord::Base
  attr_accessible :impact_statement, :other_services, :purpose, :resolution, :sender_uid, :subject, :window_end, :window_start, :workaround
  has_many :damages
  has_many :impacted_services, :through => :damages
  has_many :broadcasts
  has_many :events, :through => :broadcasts
  has_many :audiences
  has_many :recipients, :through => :audiences
  
  belongs_to :classification
  belongs_to :modifier
end
