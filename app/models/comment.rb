# Implements basic commenting support

class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :character
  
  validates :character_id, :presence => true
  validates :user_id, :presence => true
  validates :body, :presence => true
end
