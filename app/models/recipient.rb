class Recipient < ActiveRecord::Base
  attr_accessible :uid
  has_many :audiences
  has_many :messages, :through => :audiences
end
