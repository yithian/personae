class Clique < ActiveRecord::Base
  has_many :characters
  belongs_to :user
  
  validates_uniqueness_of :name
end
