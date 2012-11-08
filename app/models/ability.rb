# This class handles authorization via the CanCan gem. The only real
# contents of it is Ability.initialize(user), which contains the
# authorization permissions settings.

class Ability
  include CanCan::Ability

  # Contains the authorization permissions map for user objects. As
  # of now, the only two roles are admin and !admin, whose permissions
  # are defined inside.
  def initialize(user)
    # Define abilities for the passed in user here
    user ||= User.new # guest user (not logged in)
    
    if user.admin?
      can :manage, :all
      cannot :edit, Clique, :name => "Solitary"
      cannot :update, Clique, :name => "Solitary"
      cannot :destroy, Clique, :name => "Solitary"
    else
      # granular character permissions
      can :read, Character, :read_name => true
      can :read_nature, Character, :read_nature => true
      can :read_clique, Character, :read_clique => true
      can :read_idology, Character, :read_ideology => true
      can :read_description, Character, :read_description => true
      can :read_background, Character, :read_background => true

      can :shapeshift, Character

      # can manage characters created by yourself and any character
      # in a chronicle you created
      can :manage, Character, :owner_id => user.id
      can :manage, Character do |character|
        character.new_record? or user.super_user?(character.chronicle)
      end

      # defines who can see a clique's name
      can :read, Clique, :name => "Solitary"
      can :read, Clique do |clique|
        known_clique = false
        
        clique.characters.each do |member|
          known_clique = true if can? :read_clique, member
          break if known_clique
        end

        known_clique
      end
      
      # can manage cliques created by yourself and any clique
      # in a chronicle you created
      can :manage, Clique, :write => true
      can :manage, Clique, :owner_id => user.id
      can :manage, Clique do |clique|
        if clique.chronicle.nil?
          # new cliques don't have a chronicle set
          true
        else
          clique.chronicle.owner == user
        end
      end

      can :manage, Chronicle, :owner_id => user.id
      can :manage, Comment, :user_id => user.id
      can :manage, User, :id => user.id
      can :obsidian, :connect
      can :obsidian, :disconnect

      # universal permissions
      can :read, Chronicle
      can :read, Nature
      can :read, Ideology
    end
    
    # The first argument to `can` is the action you are giving the user permission to do.
    # If you pass :manage it will apply to every action. Other common actions here are
    # :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. If you pass
    # :all it will apply to every resource. Otherwise pass a Ruby class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
