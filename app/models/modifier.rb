class Modifier < ActiveRecord::Base
  has_many :messages

  validates :description, presence: true
end
