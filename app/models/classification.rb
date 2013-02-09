class Classification < ActiveRecord::Base
  attr_accessible :description
  has_many :messages
end
