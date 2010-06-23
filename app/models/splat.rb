class Splat < ActiveRecord::Base
  has_many :characters
  has_many :ideologies
  has_many :natures
end
