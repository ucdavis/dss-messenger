class Recipient < ActiveRecord::Base
  attr_accessible :uid, :name
  has_many :audiences
  has_many :messages, :through => :audiences
end
