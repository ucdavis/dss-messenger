class Message < ActiveRecord::Base
  attr_accessible :impact_statement, :other_services, :purpose, :resolution, :sender_uid, :subject, :window_end, :window_start, :workaround, :recipient_ids, :messenger_event_ids, :impacted_service_ids
  has_many :damages
  has_many :impacted_services, :through => :damages
  
  has_many :broadcasts
  has_many :messenger_events, :through => :broadcasts
  
  has_many :audiences
  has_many :recipients, :through => :audiences
  
  belongs_to :classification
  belongs_to :modifier

  # Filters to limit the result to specified criterion
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
      :recipients => self.recipients,
      :recipient_ids => self.recipients.pluck(:recipient_id),
      :impacted_services => self.impacted_services,
      :impacted_service_ids => self.impacted_services.pluck(:impacted_service_id),
      :messenger_events => self.messenger_events,
      :messenger_event_ids => self.messenger_events.pluck(:messenger_event_id),
      :created_at => self.created_at
    }
    
  end
end
