class Recipient < ActiveRecord::Base
  has_many :audiences
  has_many :messages, :through => :audiences

  validates :uid, presence: true
end
