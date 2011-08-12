# This class handles authorization via the CanCan gem. The only real
# contents of it is Ability.initialize(user), which contains the
# authorization permissions settings.

class Ability
  include CanCan::Ability

  # Contains the authorization permissions map for user objects. As
  # of now, the only two roles are admin and !admin, whose permissions
  # are defined inside.
  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    user ||= User.new # guest user (not logged in)
    
    if user.admin?
      can :manage, :all
      cannot :edit, Clique, :name => "Solitary"
      cannot :update, Clique, :name => "Solitary"
      cannot :destroy, Clique, :name => "Solitary"
    else
      # can manage characters created by yourself and any character
      # in a chronicle you created
      can :manage, Character, :owner_id => user.id
      can :manage, Character, do |character|
        user.chronicles.each do |chronicle|
          return true if character.chronicle_id == chronicle.id
        end
      end
      can :shapeshift, Character

      # can manage cliques created by yourself and any clique
      # in a chronicle you created
      can :manage, Clique, :owner_id => user.id
      can :manage, Clique, do |clique|
        user.chronicles.each do |chronicle|
          return true if clique.chronicle_id == chronicle.id
        end
      end

      can :manage, Chronicle, :owner_id => user.id
      can :manage, Comment, :user_id => user.id
      can :manage, User, :id => user.id
      can :obsidian, :connect
      can :obsidian, :disconnect
      can :read, :all
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
