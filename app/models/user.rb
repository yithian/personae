require 'digest/sha1'

class NotBlankValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors[attribute] << "must not be blank" if value.blank?
  end
end

class User < ActiveRecord::Base
  has_many :characters, :dependent => :destroy
  has_many :comments
  has_many :cliques
  
  validates :name, :presence => true, :uniqueness => true
  
  attr_accessor :password_confirmation
  validates_confirmation_of :password
  
  validates :password, :not_blank => true
  
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
  
  # password is a virtual attribute
  def password
    @password
  end
  
  def password=(pwd)
    @password = pwd
    return if pwd.blank?
    create_new_salt
    self.hashed_password = User.encrypted_password(self.password, self.salt)
  end
  
  private
  def create_new_salt
    self.salt = self.object_id.to_s + rand.to_s
  end
  
  def self.encrypted_password(password, salt)
    string_to_hash = password + "random" + salt
    Digest::SHA1.hexdigest(string_to_hash)
  end
end
