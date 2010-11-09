class Clique < ActiveRecord::Base
  has_many :characters
  belongs_to :user
  
  validates :name, :presence => true, :uniqueness => true
  validates :user_id, :presence => true

  def is_known_to_user?(user_id)
    known_clique = false
    known_clique = true if user_id == User.find_by_name("Storyteller").id or self.user_id == user_id or self.write or self.id == Clique.find_by_name("Solitary").id
    self.characters.each do |member|                                                                                                                        
      known_clique = true if member.read_clique                                                                                                                
    end

    known_clique
  end

  def can_edit_as_user?(user_id)
    owned_by_user?(user_id) or self.write unless self.id == Clique.find_by_name("Solitary").id
  end

  def can_destroy_as_user?(user_id)
    owned_by_user?(user_id) unless self.id == Clique.find_by_name("Solitary").id
  end
  
  private
  def owned_by_user?(user_id)
    self.user_id == user_id or user_id == User.find_by_name("Storyteller").id
  end
end
