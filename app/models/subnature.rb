# Subnature is only meaningful to the Changeling splat, and is
# included to represent their kiths. No other splat has an
# analogous item.

class Subnature < ActiveRecord::Base
  has_many :characters
  belongs_to :splat
  belongs_to :nature

  validates :name, :presence => true, :uniqueness => true
  validates :nature_id, :presence => true
  validates :splat_id, :presence => true

  # List subnatures for a given nature
  def self.list_for_nature(nature)
    subnatures = Subnature.where(nature_id: 0, splat_id: nature.splat.id)
    subnatures = subnatures + Subnature.where(nature_id: nature.id)
    subnatures.collect
  end
end
