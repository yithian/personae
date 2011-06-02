require 'digest/sha2'

# Creates a validator for User.name to ensure that it isn't empty

class NotBlankValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors[attribute] << "must not be blank" if value.blank?
  end
end

# Contains user-specific data. Which characters are theirs, which cliques
# and chromicles they've created, etc.
# 
# The built-in user named Storyteller is treated as having full ownership
# of everything in personae. In the future, admin permissions will be added
# on a per-user basis (probably for an entire Chronicle).

class User < ActiveRecord::Base
  has_many :characters, :dependent => :destroy
  has_many :comments
  has_many :cliques
  belongs_to :chronicle
  
  validates :name, :presence => true, :uniqueness => true
  validates :password, :presence => true, :not_blank => true, :on => :create
  validates_confirmation_of :password
  validates :email_address, :presence => true, :uniqueness => true, :format => { :with => /.*\@.*\.*/}
  
  # Clean up after the deletion of a non-Storyteller user
  before_destroy do |user|
    if user == User.find_by_name("Storyteller")
      raise "Can't delete the Storyteller user"
    end

    if User.count == 1
      raise "Can't delete the last user"
    end

    user.cliques.each do |clique|
      clique.user_id = User.find_by_name("Storyteller").id
      clique.save
    end
  end
  
  # Authenticate a user, using their password. User passwords are stored with a one-way-hash
  # using SHA2 and a salt value. Returns the user object for the authenticated user.
  def self.authenticate(name, password)
    user = self.find_by_name(name)
    if user
      expected_password = encrypted_password(password, user.salt)
      if user.hashed_password != expected_password
        user = nil
      end
    end
    user
  end

  # Generates a reset code for a user. This is to provide an alternate means of authentication
  # for users who have forgotten their password.
  def generate_reset_code
    self.attributes = {:reset_code => Digest::SHA2.hexdigest(Time.now.to_s.split(//).sort { rand }.join)}
    self.save(:validate => false)
  end

  # Clears the reset code after it has been used.
  def clear_reset_code
    self.attributes = {:reset_code => nil}
    self.save(:validate => false)
  end
  
  # Since password is actually stored as an encrypted value, .password is a virtual attribute.
  # This is the read accessor.
  def password
    @password
  end
  
  # Since password is actually stored as an encrypted value, .password is a virtual attribute.
  # This is the write accessor. It also creates a new salt value and stores the new hashed value.
  def password=(pwd)
    @password = pwd
    return if pwd.blank?
    create_new_salt
    self.hashed_password = User.encrypted_password(self.password, self.salt)
  end
  
  # Returns true if the logged in user can edit the user
  def can_edit_as_user?(user_id)
    self.id == user_id or user_id == User.find_by_name("Storyteller").id
  end
  
  # Returns true if the logged in user can destroy the user
  def can_destroy_as_user?(user_id)
    self.id == user_id or user_id == User.find_by_name("Storyteller").id unless self.id == User.find_by_name("Storyteller").id
  end

  private
  # Creates a new salt value for the password hash.
  def create_new_salt
    self.salt = self.object_id.to_s + rand.to_s
  end
  
  # Encrypts and returns the password.
  def self.encrypted_password(password, salt)
    string_to_hash = password + "random" + salt
    Digest::SHA2.hexdigest(string_to_hash)
  end
end
