class Modifier < ActiveRecord::Base
  attr_accessible :description, :open_ended
  has_many :messages

  validates :description, presence: true
end
