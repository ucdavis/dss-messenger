class Message < ActiveRecord::Base
  include ActionView::Helpers::DateHelper
  
  attr_accessible :impact_statement, :other_services, :purpose, :resolution, :sender_uid, :subject, :window_end, :window_start, :workaround, :classification_id, :modifier_id, :recipient_uids, :impacted_service_ids, :closed, :publisher_ids
  
  has_many :damages
  has_many :impacted_services, :through => :damages
  
  has_many :audiences
  has_many :recipients, :through => :audiences
  
  belongs_to :classification
  belongs_to :modifier
  
  has_many :logs, :class_name => "MessageLog"
  has_many :publishers, :through => :logs

  # Validations
  validates :subject, presence: true
  validates :impact_statement, presence: true
  validates_presence_of :recipients

  # Filters to limit the result to specified criterion
  scope :by_classification, lambda { |classification| where(classification_id: classification) unless classification.nil? }
  scope :by_modifier, lambda { |modifier| where(modifier_id: modifier) unless modifier.nil? }
  scope :by_service, lambda { |service| joins(:impacted_services).where('impacted_services.id = ?', service) unless service.nil? }
  
  def recipient_uids=(ids_str)
    ids_str.split(",").each do |r|
      name = Entity.find(r).name
      recipient = Recipient.find_or_create_by_uid(uid: r, name: name)
      self.recipients << recipient unless self.recipients.include?(recipient) # Avoid duplicates
    end
  end
  
  def as_json(options = {})
    {
      :id => self.id,
      :closed => self.closed,
      :impact_statement => self.impact_statement,
      :other_services => self.other_services,
      :purpose => self.purpose,
      :resolution => self.resolution,
      :sender_uid => self.sender_uid,
      :sender_name => Person.find(self.sender_uid).name,
      :subject => self.subject,
      :window_start => 
        if self.window_start
          self.window_start.strftime("%Y/%m/%d %I:%M %p")
        else
          self.window_start
        end,
      :window_end =>
        if self.window_end
          self.window_end.strftime("%Y/%m/%d %I:%M %p")
        else
          self.window_end
        end,
      :workaround => self.workaround,
      :classification_id => self.classification_id,
      :classification => self.classification,
      :modifier_id => self.modifier_id,
      :modifier => self.modifier,
      :recipients => self.recipients,
      :recipient_uids => self.recipients.map(&:uid).join(","),
      :impacted_services => self.impacted_services,
      :created_at => self.created_at.strftime("%A, %B %d, %Y at %l:%M %p"),
      :created_at_in_words => time_ago_in_words(self.created_at) + ' ago',
      :publishers => self.publishers,
      :recipient_counts =>
        if self.logs
          self.logs.map do |log|
            {
              :publisher => log.publisher ? log.publisher.name : 'E-mail',
              :count => log.recipient_count,
              :viewed => log.viewed_count
            }
          end
        else
          []
        end,
      :send_status =>
        if self.logs
          self.logs.map do |log|
            log.send_status.to_s.capitalize
          end
        else
          'Unavailable'
        end
    }
    
  end
end
