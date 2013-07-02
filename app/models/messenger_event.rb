class MessengerEvent < ActiveRecord::Base
  attr_accessible :description
  has_many :broadcasts
  has_many :messages, :through => :broadcasts

  validates :description, presence: true
end
