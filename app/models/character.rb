# The basic building block of personae, the character class represents a
# World of Darkness character. Specifically, it holds all the information
# that would be represented on a player's character sheet.
# 
# All required attributes have default values.
# 
# The Storyteller user is considered to be an owner of every character.

class Character < ActiveRecord::Base
  belongs_to :clique
  belongs_to :ideology
  belongs_to :nature
  belongs_to :subnature
  belongs_to :splat 
  belongs_to :owner, :class_name => "User"
  belongs_to :chronicle
  has_many :comments, :dependent => :destroy
  
  # An Array of Strings of valid virtues in World of Darkness games. Primarily used to
  # populate dropdown menus.
  VIRTUES = [ 'Charity', 'Faith', 'Fortitude', 'Hope', 'Justice', 'Prudence', 'Temperance' ]

  # An Array of Strings of valid vices in World of Darkness games. Primarily used to
  # populate dropdown menus.
  VICES = [ 'Envy', 'Gluttony', 'Greed', 'Lust', 'Sloth', 'Pride', 'Wrath' ]
  
  validates :name, :presence => true, :uniqueness => true
  validates :virtue, :presence => true, :virtue => true
  validates :vice, :presence => true, :vice => true
  validates :clique_id, :presence => true, :numericality => true
  validates :ideology_id, :numericality => true
  validates :splat_id, :numericality => true
  validates :nature_id, :numericality => true
  validates :intelligence, :presence => true, :numericality => {:greater_than_or_equal_to => 0}
  validates :strength, :presence => true, :numericality => {:greater_than_or_equal_to => 0}
  validates :presence, :presence => true, :numericality => {:greater_than_or_equal_to => 0}
  validates :wits, :presence => true, :numericality => {:greater_than_or_equal_to => 0}
  validates :dexterity, :presence => true, :numericality => {:greater_than_or_equal_to => 0}
  validates :manipulation, :presence => true, :numericality => {:greater_than_or_equal_to => 0}
  validates :resolve, :presence => true, :numericality => {:greater_than_or_equal_to => 0}
  validates :stamina, :presence => true, :numericality => {:greater_than_or_equal_to => 0}
  validates :composure, :presence => true, :numericality => {:greater_than_or_equal_to => 0}
  validates :academics, :presence => true, :numericality => {:greater_than_or_equal_to => 0}
  validates :athletics, :presence => true, :numericality => {:greater_than_or_equal_to => 0}
  validates :animal_ken, :presence => true, :numericality => {:greater_than_or_equal_to => 0}
  validates :computer, :presence => true, :numericality => {:greater_than_or_equal_to => 0}
  validates :brawl, :presence => true, :numericality => {:greater_than_or_equal_to => 0}
  validates :empathy, :presence => true, :numericality => {:greater_than_or_equal_to => 0}
  validates :crafts, :presence => true, :numericality => {:greater_than_or_equal_to => 0}
  validates :drive, :presence => true, :numericality => {:greater_than_or_equal_to => 0}
  validates :expression, :presence => true, :numericality => {:greater_than_or_equal_to => 0}
  validates :investigation, :presence => true, :numericality => {:greater_than_or_equal_to => 0}
  validates :firearms, :presence => true, :numericality => {:greater_than_or_equal_to => 0}
  validates :intimidation, :presence => true, :numericality => {:greater_than_or_equal_to => 0}
  validates :medicine, :presence => true, :numericality => {:greater_than_or_equal_to => 0}
  validates :larceny, :presence => true, :numericality => {:greater_than_or_equal_to => 0}
  validates :persuasion, :presence => true, :numericality => {:greater_than_or_equal_to => 0}
  validates :occult, :presence => true, :numericality => {:greater_than_or_equal_to => 0}
  validates :stealth, :presence => true, :numericality => {:greater_than_or_equal_to => 0}
  validates :socialize, :presence => true, :numericality => {:greater_than_or_equal_to => 0}
  validates :politics, :presence => true, :numericality => {:greater_than_or_equal_to => 0}
  validates :survival, :presence => true, :numericality => {:greater_than_or_equal_to => 0}
  validates :streetwise, :presence => true, :numericality => {:greater_than_or_equal_to => 0}
  validates :science, :presence => true, :numericality => {:greater_than_or_equal_to => 0}
  validates :weaponry, :presence => true, :numericality => {:greater_than_or_equal_to => 0}
  validates :subterfuge, :presence => true, :numericality => {:greater_than_or_equal_to => 0}
  validates :speed, :presence => true, :numericality => {:greater_than_or_equal_to => 0}
  validates :initiative, :presence => true, :numericality => {:greater_than_or_equal_to => 0}
  validates :defense, :presence => true, :numericality => {:greater_than_or_equal_to => 0}
  validates :morality, :presence => true, :numericality => {:greater_than_or_equal_to => 0}
  validates :power_stat, :numericality => {:greater_than_or_equal_to => 0}
  validates :max_fuel, :numericality => {:greater_than_or_equal_to => 0}
  validates :current_fuel, :numericality => {:greater_than_or_equal_to => 0}
  validates :death, :numericality => {:greater_than_or_equal_to => 0}
  validates :fate, :numericality => {:greater_than_or_equal_to => 0}
  validates :forces, :numericality => {:greater_than_or_equal_to => 0}
  validates :life, :numericality => {:greater_than_or_equal_to => 0}
  validates :matter, :numericality => {:greater_than_or_equal_to => 0}
  validates :mind, :numericality => {:greater_than_or_equal_to => 0}
  validates :prime, :numericality => {:greater_than_or_equal_to => 0}
  validates :space, :numericality => {:greater_than_or_equal_to => 0}
  validates :spirit, :numericality => {:greater_than_or_equal_to => 0}
  validates :time, :numericality => {:greater_than_or_equal_to => 0}
  validates :purity, :numericality => {:greater_than_or_equal_to => 0}
  validates :glory, :numericality => {:greater_than_or_equal_to => 0}
  validates :honor, :numericality => {:greater_than_or_equal_to => 0}
  validates :wisdom, :numericality => {:greater_than_or_equal_to => 0}
  validates :cunning, :numericality => {:greater_than_or_equal_to => 0}
  validates :animalism, :numericality => {:greater_than_or_equal_to => 0}
  validates :auspex, :numericality => {:greater_than_or_equal_to => 0}
  validates :celerity, :numericality => {:greater_than_or_equal_to => 0}
  validates :dominate, :numericality => {:greater_than_or_equal_to => 0}
  validates :majesty, :numericality => {:greater_than_or_equal_to => 0}
  validates :nightmare, :numericality => {:greater_than_or_equal_to => 0}
  validates :protean, :numericality => {:greater_than_or_equal_to => 0}
  validates :obfuscate, :numericality => {:greater_than_or_equal_to => 0}
  validates :vigor, :numericality => {:greater_than_or_equal_to => 0}
  validates :dream, :numericality => {:greater_than_or_equal_to => 0}
  validates :hearth, :numericality => {:greater_than_or_equal_to => 0}
  validates :mirror, :numericality => {:greater_than_or_equal_to => 0}
  validates :smoke, :numericality => {:greater_than_or_equal_to => 0}
  validates :artifice, :numericality => {:greater_than_or_equal_to => 0}
  validates :darkness, :numericality => {:greater_than_or_equal_to => 0}
  validates :elements, :numericality => {:greater_than_or_equal_to => 0}
  validates :fang_and_tooth, :numericality => {:greater_than_or_equal_to => 0}
  validates :stone, :numericality => {:greater_than_or_equal_to => 0}
  validates :vainglory, :numericality => {:greater_than_or_equal_to => 0}
  validates :fleeting_spring, :numericality => {:greater_than_or_equal_to => 0}
  validates :eternal_spring, :numericality => {:greater_than_or_equal_to => 0}
  validates :fleeting_summer, :numericality => {:greater_than_or_equal_to => 0}
  validates :eternal_summer, :numericality => {:greater_than_or_equal_to => 0}
  validates :fleeting_autumn, :numericality => {:greater_than_or_equal_to => 0}
  validates :eternal_autumn, :numericality => {:greater_than_or_equal_to => 0}
  validates :fleeting_winter, :numericality => {:greater_than_or_equal_to => 0}
  validates :eternal_winter, :numericality => {:greater_than_or_equal_to => 0}
  validates :boneyard, :numericality => {:greater_than_or_equal_to => 0}
  validates :caul, :numericality => {:greater_than_or_equal_to => 0}
  validates :curse, :numericality => {:greater_than_or_equal_to => 0}
  validates :oracle, :numericality => {:greater_than_or_equal_to => 0}
  validates :marionette, :numericality => {:greater_than_or_equal_to => 0}
  validates :rage, :numericality => {:greater_than_or_equal_to => 0}
  validates :shroud, :numericality => {:greater_than_or_equal_to => 0}

  # Returns true if the given user has permission to read the character's name.
  # This is also the check used to determine if a character's entry shows up in
  # index and clique pages, etc. Defaults to false.
  def show_name_to_user?(user)
    owned_by_user?(user) or self.read_name
  end
  
  # Returns true if the given user has permission to read the character's nature.
  # Defaults to false.
  def show_nature_to_user?(user)
    owned_by_user?(user) or self.read_nature unless self.splat.name == "Mortal"
  end
  
  # Returns true if the given user has permission to read the character's clique.
  # Defaults to false.
  def show_clique_to_user?(user)
    owned_by_user?(user) or self.read_clique
  end
  
  # Returns true if the given user has permission to read the character's ideology.
  # Defaults to false.
  def show_ideology_to_user?(user)
    owned_by_user?(user) or self.read_ideology unless self.splat.name == "Mortal"
  end
  
  # Returns true if the given user has permission to read the character's description.
  # Defaults to false.
  def show_description_to_user?(user)
    owned_by_user?(user) or self.read_description
  end
  
  # Returns true if the given user has permission to read the character's background.
  # Defaults to false.
  def show_background_to_user?(user)
    owned_by_user?(user) or self.read_background
  end
  
  # Returns true if the given user has permission to read the character's deeds.
  # Defaults to true.
  def show_deeds_to_user?(user)
    owned_by_user?(user) or self.read_deeds
  end
  
  # Returns true if the given user has permission to read the character's attributes
  # (Strength, Wits, etc). Defaults to false.
  def show_attributes_to_user?(user)
    owned_by_user?(user) or self.read_attributes
  end
  
  # Returns true if the given user has permission to read the character's skills
  # (Academics, Firearms, etc). Defaults to false.
  def show_skills_to_user?(user)
    owned_by_user?(user) or self.read_skills
  end
  
  # Returns true if the given user has permission to read the character's advantages
  # (Morality, Health, etc). Defaults to false.
  def show_advantages_to_user?(user)
    owned_by_user?(user) or self.read_advantages
  end
  
  # Returns true if the given user has permission to read the character's merits
  # Defaults to false.
  def show_merits_to_user?(user)
    owned_by_user?(user) or self.read_merits
  end
  
  # Returns true if the given user has permission to read the character's supernatural
  # powers. These are associated with the character's nature. Defaults to false.
  def show_powers_to_user?(user)
    owned_by_user?(user) or self.read_powers
  end
  
  # Returns true if the given user has permission to read the character's equipment
  # Defaults to false.
  def show_equipment_to_user?(user)
    owned_by_user?(user) or self.read_equipment
  end
  
  # Returns true if the given user has permission to read the character's experience.
  # Defaults to false.
  def show_experience_to_user?(user)
    owned_by_user?(user) or self.read_experience
  end

  # Returns true if the given user has permission to read the character's notes.
  # Defaults to false.
  def show_notes_to_user?(user)
    owned_by_user?(user) or self.read_notes
  end
  
  # Returns true if the character is a mortal or a hunter (close enough).
  def is_mortal?
    self.splat.name == "Mortal" or self.splat.name == "Hunter"
  end
  
  # Returns true if the character is a mage.
  def is_mage?
    self.splat.name == "Mage"
  end
  
  # Returns true if the character is a werewolf.
  def is_werewolf?
    self.splat.name == "Werewolf"
  end

  # Returns true if the character is a vampire.
  def is_vampire?
    self.splat.name == "Vampire"
  end

  # Returns true if the character is a promethean.
  def is_promethean?
    self.splat.name == "Promethean"
  end

  # Returns true if the character is a changeling.
  def is_changeling?
    self.splat.name == "Changeling"
  end
  
  # Returns true if the character is a geist.
  def is_geist?
    self.splat.name == "Geist"
  end
  
  # List characters known to the given user
  def self.known_to(user, selected_chronicle=user.selected_chronicle.id)
    characters = Character.find_all_by_chronicle_id(selected_chronicle, :order => "clique_id ASC").collect do |c|
      c if c.show_name_to_user?(user)
    end
    
    characters.delete_if { |c| c == nil }
  end

  private
  # Returns true if the character is owned by the logged in user or if the
  # logged in user is the Storyteller.
  def owned_by_user?(user)
    return false unless user
    user.admin? or self.owner == user
  end
end
