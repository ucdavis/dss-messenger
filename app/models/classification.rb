class Classification < ActiveRecord::Base
  has_many :messages

  validates :description, presence: true

  def short_description
    if self.description and self.description.index(':')
      return self.description.slice(0..(self.description.index(':') - 1))
    else
      return self.description
    end
  end
end
