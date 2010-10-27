class Ideology < ActiveRecord::Base
  has_many :characters
  belongs_to :splat

  validates :name, :presence => true, :uniqueness => true
  validates :splat_id, :presence => true
  
  def is_known_to_user?(current_uid)
    known_ideology = false
    known_ideology = true if current_uid == User.find_by_name('Storyteller').id
    self.characters.each do |member|
      known_ideology = true if member.read_ideology
    end
    User.find_by_id(current_uid).characters.each do |character|
      known_ideology = true if self.id == character.ideology.id
    end

    known_ideology
  end

  def can_edit_as_user?(current_uid)
    current_uid == User.find_by_name("Storyteller").id
  end

  def can_destroy_as_user?(current_uid)
    current_uid == User.find_by_name("Storyteller").id
  end
end
