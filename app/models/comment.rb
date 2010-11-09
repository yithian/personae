class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :character
  
  validates :character_id, :presence => true
  validates :user_id, :presence => true
  validates :body, :presence => true
  
  def can_edit_as_user?(user_id)
    self.user_id == user_id or user_id == User.find_by_name("Storyteller").id
  end
end
