class Subnature < ActiveRecord::Base
  has_many :characters
  belongs_to :splat
  belongs_to :nature
  
  validates :name, :presence => true, :uniqueness => true
  validates :nature_id, :presence => true
  validates :splat_id, :presence => true
end
