class ImpactedService < ActiveRecord::Base
  has_many :damages
  has_many :messages, :through => :damages

  validates :name, presence: true
end
