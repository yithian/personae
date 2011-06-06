# Contains user-specific data. Which characters are theirs, which cliques
# and chromicles they've created, etc.
# 
# The built-in user named Storyteller is treated as having full ownership
# of everything in personae. In the future, admin permissions will be added
# on a per-user basis (probably for an entire Chronicle).

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me
  has_many :characters, :foreign_key => "owner_id", :dependent => :destroy
  has_many :comments
  has_many :cliques, :foreign_key => "owner_id"
  has_many :chronicles
  belongs_to :selected_chronicle, :class_name => "Chronicle"
  
  validates :name, :presence => true, :uniqueness => true
  
  # Clean up after the deletion of a non-Storyteller user
  before_destroy do |user|
    if user == User.find_by_name("Storyteller")
      raise "Can't delete the Storyteller user"
    end

    if User.count == 1
      raise "Can't delete the last user"
    end

    user.cliques.each do |clique|
      clique.owner.id = User.find_by_name("Storyteller").id
      clique.save
    end
  end
  
  # Returns true if the current user is a super user. This will
  # probably need to change as the permissions model changes.
  def super_user?
    self.name == "Storyteller"
  end
end
