# Creates a validator for Character.virtue . Valid virtues are 'Charity', 'Faith', 'Fortitude'
# 'Hope', 'Justice', 'Prudence' and 'Temperance'

class VirtueValidator < ActiveModel::EachValidator
  # Validates all records passed to it
  def validate_each(record, attribute, value)
    unless [ 'Charity', 'Faith', 'Fortitude', 'Hope', 'Justice', 'Prudence', 'Temperance' ].include?(value)
      record.errors[attribute] << "#{value} is an invalid virtue"
    end
  end
end

# Creates a validator for Character.vice . Valid vices are 'Envy', 'Gluttony', 'Greed', 'Lust'
# 'Sloth', 'Pride', 'Wrath'

class ViceValidator < ActiveModel::EachValidator
  # Validates all records passed to it
  def validate_each(record, attribute, value)
    unless [ 'Envy', 'Gluttony', 'Greed', 'Lust', 'Sloth', 'Pride', 'Wrath' ].include?(value)
      record.errors[attribute] << "#{value} is an invalid vice"
    end
  end
end

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
  validates :intelligence, :presence => true, :numericality => true
  validates :strength, :presence => true, :numericality => true
  validates :presence, :presence => true, :numericality => true
  validates :wits, :presence => true, :numericality => true
  validates :dexterity, :presence => true, :numericality => true
  validates :manipulation, :presence => true, :numericality => true
  validates :resolve, :presence => true, :numericality => true
  validates :stamina, :presence => true, :numericality => true
  validates :composure, :presence => true, :numericality => true
  validates :academics, :presence => true, :numericality => true
  validates :athletics, :presence => true, :numericality => true
  validates :animal_ken, :presence => true, :numericality => true
  validates :computer, :presence => true, :numericality => true
  validates :brawl, :presence => true, :numericality => true
  validates :empathy, :presence => true, :numericality => true
  validates :crafts, :presence => true, :numericality => true
  validates :drive, :presence => true, :numericality => true
  validates :expression, :presence => true, :numericality => true
  validates :investigation, :presence => true, :numericality => true
  validates :firearms, :presence => true, :numericality => true
  validates :intimidation, :presence => true, :numericality => true
  validates :medicine, :presence => true, :numericality => true
  validates :larceny, :presence => true, :numericality => true
  validates :persuasion, :presence => true, :numericality => true
  validates :occult, :presence => true, :numericality => true
  validates :stealth, :presence => true, :numericality => true
  validates :socialize, :presence => true, :numericality => true
  validates :politics, :presence => true, :numericality => true
  validates :survival, :presence => true, :numericality => true
  validates :streetwise, :presence => true, :numericality => true
  validates :science, :presence => true, :numericality => true
  validates :weaponry, :presence => true, :numericality => true
  validates :subterfuge, :presence => true, :numericality => true
  validates :speed, :presence => true, :numericality => true
  validates :initiative, :presence => true, :numericality => true
  validates :defense, :presence => true, :numericality => true
  validates :morality, :presence => true, :numericality => true
  validates :power_stat, :numericality => true
  validates :max_fuel, :numericality => true
  validates :current_fuel, :numericality => true
  validates :death, :numericality => true
  validates :fate, :numericality => true
  validates :forces, :numericality => true
  validates :life, :numericality => true
  validates :matter, :numericality => true
  validates :mind, :numericality => true
  validates :prime, :numericality => true
  validates :space, :numericality => true
  validates :spirit, :numericality => true
  validates :time, :numericality => true
  validates :purity, :numericality => true
  validates :glory, :numericality => true
  validates :honor, :numericality => true
  validates :wisdom, :numericality => true
  validates :cunning, :numericality => true
  validates :animalism, :numericality => true
  validates :auspex, :numericality => true
  validates :celerity, :numericality => true
  validates :dominate, :numericality => true
  validates :majesty, :numericality => true
  validates :nightmare, :numericality => true
  validates :protean, :numericality => true
  validates :obfuscate, :numericality => true
  validates :vigor, :numericality => true

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
  def self.known_to(user, selected_chronicle=user.selected_chronicle)
    characters = Character.find_all_by_chronicle_id(selected_chronicle.id, :order => "clique_id ASC").collect do |c|
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
