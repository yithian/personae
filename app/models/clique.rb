# Cliques are close-knit social groups typically consisting of three
# to ten members. Characters may belong to only one clique.
require 'ability.rb'

class Clique < ActiveRecord::Base
  has_many :characters
  belongs_to :owner, :class_name => "User"
  belongs_to :chronicle
  
  validates :name, :presence => true, :unique_in_chronicle => true
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

  # Show the clique's name in the url
  def to_param
    "#{self.id}-#{self.name.gsub(/[ '"#%\{\}|\\^~\[\]`]/, '-').gsub(/[.&?\/:;=@]/, '')}"
  end

  # List cliques konwn to the given user
  # if the user provided is nil, create a new, temporary user
  # as a base
  def self.known_to(user, chronicle_id=user.selected_chronicle.id)
    cliques = Clique.find_all_by_chronicle_id(0)
    
    cliques = cliques + Clique.find_all_by_chronicle_id(chronicle_id)
    
    cliques.delete_if { |c| c == nil }
  end
  
  # Returns true if the character is owned by the logged in user or if the logged in user is
  # the a User.super_user?
  def owned_by_user?(user)
    return false unless user
    self.owner == user or user.super_user?(self.chronicle)
  end
end
