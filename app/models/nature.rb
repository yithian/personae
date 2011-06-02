# Represents the inborn tendencies and attitudes of a supernatural template.

class Nature < ActiveRecord::Base
  has_many :characters
  has_many :subnatures
  belongs_to :splat

  validates :name, :presence => true, :uniqueness => true
  validates :splat_id, :presence => true
end
