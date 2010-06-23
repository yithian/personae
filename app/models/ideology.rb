class Ideology < ActiveRecord::Base
  has_many :characters
  belongs_to :splat
end
