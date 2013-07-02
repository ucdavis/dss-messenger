class ImpactedService < ActiveRecord::Base
  attr_accessible :name
  has_many :damages
  has_many :messages, :through => :damages

  validates :name, presence: true
end
