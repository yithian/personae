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

  has_many :characters, foreign_key: "owner_id", :dependent => :destroy
  has_many :comments
  has_many :cliques, foreign_key: "owner_id"
  has_many :chronicles, foreign_key: "owner_id"
  belongs_to :selected_chronicle, class_name: "Chronicle"

  validates :name, :presence => true, :uniqueness => true

  # Clean up after the deletion of a non-Storyteller user
  before_destroy do |user|
    if (user.name == "Storyteller") or (User.count == 1)
      user.cliques.each do |clique|
        clique.owner.id = User.find_by_name("Storyteller").id
        clique.save
      end

      throw :abort
    else
      true
    end
  end

  # Returns true if the current user is an admin for the specified
  # chronicle.
  def super_user?(chronicle)
    self.admin? or chronicle.owner == self
  end
end
