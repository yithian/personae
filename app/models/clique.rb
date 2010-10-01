class Clique < ActiveRecord::Base
  has_many :characters
  belongs_to :user
  
  validates :name, :presence => true, :uniqueness => true
  validates :user_id, :presence => true
end
