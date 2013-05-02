class Message < ActiveRecord::Base
  attr_accessible :impact_statement, :other_services, :purpose, :resolution, :sender_uid, :subject, :window_end, :window_start, :workaround, :recipients_attributes, :messenger_events_attributes, :impacted_services_attributes, :created_at
  has_many :damages
  has_many :impacted_services, :through => :damages
  accepts_nested_attributes_for :impacted_services
  
  has_many :broadcasts
  has_many :messenger_events, :through => :broadcasts
  accepts_nested_attributes_for :messenger_events
  
  has_many :audiences
  has_many :recipients, :through => :audiences
  accepts_nested_attributes_for :recipients
  
  belongs_to :classification
  belongs_to :modifier

  def self.filter(is,me)
    if is
      joins(:damages).where( damages: { impacted_service_id: "#{is}"})
    elsif me
      joins(:broadcasts).where( broadcasts: { messenger_event_id: "#{me}"})
    else
      all
    end
  end
  
  def as_json(options = {})
    {
      :id => self.id,
      :impact_statement => self.impact_statement,
      :other_services => self.other_services,
      :purpose => self.purpose,
      :resolution => self.resolution,
      :sender_uid => self.sender_uid,
      :subject => self.subject,
      :window_start => self.window_start,
      :window_end => self.window_end,
      :workaround => self.workaround,
      :recipients_attributes => self.recipients,
      :messenger_events_attributes => self.messenger_events,
      :impacted_services_attributes => self.impacted_services,
      :created_at => self.created_at
    }
    
  end
end
