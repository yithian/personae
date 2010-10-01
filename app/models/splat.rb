class Splat < ActiveRecord::Base
  has_many :characters
  has_many :ideologies
  has_many :natures

  validates :name, :presence => true, :uniqueness => true
  validates :nature_name, :presence => true
  validates :clique_name, :presence => true
  validates :ideology_name, :presence => true
  validates :morality_name, :presence => true
  validates :power_stat_name, :presence => true
  validates :fuel_name, :presence => true
end
