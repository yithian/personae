class Ideology < ActiveRecord::Base
  has_many :characters
  belongs_to :splat

  validates :name, :presence => true, :uniqueness => true
  validates :splat_id, :presence => true
  
  # Returns true if the logged in user can see any characters with this ideology.
  def is_known_to_user?(user_id)
    known_ideology = false
    known_ideology = true if user_id == User.find_by_name('Storyteller').id
    self.characters.each do |member|
      known_ideology = true if member.read_ideology and member.show_ideology_to_user?(user_id)
    end
    User.find_by_id(user_id).characters.each do |character|
      known_ideology = true if self.id == character.ideology.id
    end

    known_ideology
  end

  def can_edit_as_user?(user_id)
    user_id == User.find_by_name("Storyteller").id unless self.id == Ideology.find_by_name("Mortal").id
  end

  def can_destroy_as_user?(user_id)
    user_id == User.find_by_name("Storyteller").id unless self.id == Ideology.find_by_name("Mortal").id
  end
end
