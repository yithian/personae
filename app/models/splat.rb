# Represents a splat, which is to say a supernatural template
# in the World of Darkness. While technically not a splat,
# mortals have a splat entry as well for compatability reasons.
# 
# Splat is basically a way to adjust the terminology used for
# the different templates. Paths are meaningless to Vampires,
# for instance, but Paths and Clans are similar enough in their
# function that they can be lumped together as Nature.

class Splat < ActiveRecord::Base
  has_many :characters
  has_many :ideologies
  has_many :natures

  validates :name, :presence => true, :uniqueness => true
  validates :nature_name, :presence => true
  validates :clique_name, :presence => true
  validates :ideology_name, :presence => true
  validates :integrity_name, :presence => true
  validates :power_stat_name, :presence => true
  validates :fuel_name, :presence => true
end
