# Cliques are close-knit social groups typically consisting of three
# to ten members. Characters may belong to only one clique.
require 'ability.rb'

class Clique < ActiveRecord::Base
  has_many :characters
  belongs_to :owner, :class_name => "User"
  belongs_to :chronicle

  validates :name, :presence => true, :unique_in_chronicle => true
  validates :owner_id, :presence => true

  # Show the clique's name in the url
  def to_param
    "#{self.id}-#{self.name.gsub(/[ '"#%\{\}|\\^~\[\]`]/, '-').gsub(/[.&?\/:;=@]/, '')}"
  end

  # List cliques konwn to the given user
  # if the user provided is nil, create a new, temporary user
  # as a base
  def self.known_to(user, chronicle_id=user.selected_chronicle.id)
    a = Ability.new(user)

    cliques = Clique.where(:chronicle_id => 0)
    cliques = cliques + Clique.where(:chronicle_id => chronicle_id)

    cliques.delete_if { |c| a.cannot? :read, c }
  end

  # Returns true if the character is owned by the logged in user or if the logged in user is
  # the a User.super_user?
  def owned_by_user?(user)
    return false unless user
    self.owner == user or user.super_user?(self.chronicle)
  end
end
