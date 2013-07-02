class Classification < ActiveRecord::Base
  attr_accessible :description
  has_many :messages
  
  validates :description, presence: true
  
end
