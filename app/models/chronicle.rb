# Chronicles contain characters and cliques -- presumably
# ideologies and natures will be static throughout all games
# -- as a way to have multiple games present in the same
# database.

class Chronicle < ActiveRecord::Base
  belongs_to :owner, :class_name => "User"
  has_many :characters
  has_many :pcs, :class_name => "Character", :conditions => {:pc => true}
  has_many :npcs, :class_name => "Character", :conditions => {:pc => false}
  has_many :cliques
  has_many :selected_users, :class_name => "User", :foreign_key => "selected_chronicle_id"
  
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
    
    c.selected_users.each do |user|
      user.selected_chronicle_id = nc
      user.save
    end
  end

  # Show the chronicle's name in the url
  def to_param
    "#{self.id}-#{self.name.gsub(' ', '-')}"
  end
end
