class Classification < ActiveRecord::Base
  has_many :messages

  validates :description, presence: true
end
