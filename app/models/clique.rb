class Clique < ActiveRecord::Base
  has_many :characters
  belongs_to :user
  
  validates :name, :presence => true, :uniqueness => true
  validates :user_id, :presence => true

  def is_known_to_user?(current_uid)
    known_clique = false
    known_clique = true if current_uid == User.find_by_name("Storyteller").id or self.user_id == current_uid or self.write or self.id == Clique.find_by_name("Solitary").id
    self.characters.each do |member|                                                                                                                        
      known_clique = true if member.read_clique                                                                                                                
    end

    known_clique
  end

  def can_edit_as_user?(current_uid)
    self.user_id == current_uid or current_uid == User.find_by_name("Storyteller").id or self.write
  end

  def can_destroy_as_user?(current_uid)
    current_uid == User.find_by_name("Storyteller").id or self.user_id == current_uid
  end
end
