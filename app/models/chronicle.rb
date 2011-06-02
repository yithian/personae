# Chronicles contain characters and cliques -- presumably
# ideologies and natures will be static throughout all games
# -- as a way to have multiple games present in the same
# database.
class Chronicle < ActiveRecord::Base
  has_many :characters
  has_many :cliques
  has_many :users
  
  validates :name, :presence => true, :uniqueness => true
  
  before_destroy do |c|
    if Chronicle.count == 1
      raise "Can't delete the last chronicle"
    end
    
    nc = Chronicle.find(:first).id
    
    c.characters.each do |character|
      character.chronicle_id = nc
      character.save
    end
    
    c.cliques.each do |clique|
      clique.chronicle_id = nc
      clique.save
    end
    
    c.users.each do |user|
      user.chronicle_id = nc
      user.save
    end
  end
  
  # Returns true if the user has admin permissions.
  def can_create_as_user?(user_id)
    super_user?(user_id)
  end
  
  # Returns true if the user has admin permissions.
  def can_edit_as_user?(user_id)
    super_user?(user_id)
  end

  # Returns true if the user has admin permissions.
  def can_destroy_as_user?(user_id)
    super_user?(user_id)
  end
  
  private
  # Returns true if the user_id belongs to Storyteller. This exists to allow
  # a future upgrade for multiple administrative accounts.
  def super_user?(user_id)
    user_id == User.find_by_name("Storyteller").id
  end
end
