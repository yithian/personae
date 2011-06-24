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
    subnatures = Subnature.find_all_by_nature_id_and_splat_id(0, nature.splat.id)
    subnatures = subnatures + Subnature.find_all_by_nature_id(nature.id)
    subnatures.collect
  end
end
