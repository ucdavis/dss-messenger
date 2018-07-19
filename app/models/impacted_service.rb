class ImpactedService < ApplicationRecord
  has_many :damages
  has_many :messages, through: :damages

  validates :name, presence: true
end
