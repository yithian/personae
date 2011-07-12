# Cliques are close-knit social groups typically consisting of three
# to ten members. Characters may belong to only one clique.

class Clique < ActiveRecord::Base
  has_many :characters
  belongs_to :owner, :class_name => "User"
  belongs_to :chronicle
  
  validates :name, :presence => true, :uniqueness => true
  validates :owner_id, :presence => true

  # Returns true if the clique has a werewolf member. Used to determine
  # if the clique's totem field should be shown in the view.
  def has_totem?
    has_werewolf = false
      self.characters.each do |char|
        has_werewolf = true if char.is_werewolf?
      end

    has_werewolf
  end

  # Returns true if the user can see any member of the clique who they
  # also can see which clique they belong to.
  def is_known_to_user?(user)
    known_clique = false
    # TODO: cliques with write=true shouldn't be editable by all users
    known_clique = true if self.write or (user and user.admin?) or (user and self.owner == user) or self == Clique.find_by_name("Solitary")

    self.characters.each do |member|
      known_clique = true if member.show_clique_to_user?(user)
    end

    known_clique
  end

  # List cliques konwn to the given user
  # if the user provided is nil, create a new, temporary user
  # as a base
  def self.known_to(user, chronicle_id=user.selected_chronicle.id)
    cliques = Clique.find_all_by_chronicle_id(0).collect do |c|
      [c.name, c.id]
    end
    
    cliques = cliques + Clique.find_all_by_chronicle_id(chronicle_id).collect do |c|
      [c.name, c.id] if c.is_known_to_user?(user)
    end
    
    cliques.delete_if { |c| c == nil }
  end
  
  # Returns true if the character is owned by the logged in user or if the logged in user is
  # the Storyteller.
  private
  def owned_by_user?(user)
    return false unless user
    self.owner == user or user.admin?
  end
end
