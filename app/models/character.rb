# encoding: utf-8

# The basic building block of personae, the character class represents a
# World of Darkness character. Specifically, it holds all the information
# that would be represented on a player's character sheet.
# 
# All required attributes have default values.
# 
# The Storyteller user is considered to be an owner of every character.

class Character < ActiveRecord::Base
  # Creates a validator for Character.virtue . Valid virtues are 'Charity', 'Faith', 'Fortitude'
  # 'Hope', 'Justice', 'Prudence' and 'Temperance'

  class VirtueValidator < ActiveModel::EachValidator
    # Validates all records passed to it
    def validate_each(record, attribute, value)
      unless Character::VIRTUES.include?(value)
        record.errors[attribute] << "#{value} is an invalid virtue"
      end
    end
  end
  
  # Creates a validator for Character.vice . Valid vices are 'Envy', 'Gluttony', 'Greed', 'Lust'
  # 'Sloth', 'Pride', 'Wrath'
  class ViceValidator < ActiveModel::EachValidator
    # Validates all records passed to it
    def validate_each(record, attribute, value)
      vices = value.split(" ")

      record.errors[attribute] << "Too many vices selected" unless vices.length < 3

      vices.each do |vice|
        unless Character::VICES.include? vice
          record.errors[attribute] << "#{vice} is an invalid vice"
        end
      end
    end
  end
  
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
  
  validates :name, :presence => true, :unique_in_chronicle => true
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
  validates :envy, :gluttony, :greed, :lust, :sloth, :pride, :wrath, :numericality => {:greater_than_or_equal_to => 0}

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
  
  # Returns true if the given user has permission to read the character's cruch
  # (Strength, Drive, powers, etc). Defaults to false.
  def show_crunch_to_user?(user)
    owned_by_user?(user) or self.read_crunch
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
  
  # Returns true if the character is a hunter (close enough).
  def is_hunter?
    self.splat.name == "Hunter"
  end
  
  # Returns true if the character is a geist.
  def is_geist?
    self.splat.name == "Geist"
  end
  
  # Returns true if the character is possessed. (This is mostly just for standardization)
  def is_possessed?
    self.possessed
  end

  def max_infernal_will
    if self.primary_vice == "Envy"
      return self.envy
    elsif self.primary_vice == "Gluttony"
      return self.gluttony
    elsif self.primary_vice == "Greed"
      return self.greed
    elsif self.primary_vice == "Lust"
      return self.lust
    elsif self.primary_vice == "Pride"
      return self.pride
    elsif self.primary_vice == "Sloth"
      return self.sloth
    elsif self.primary_vice == "Wrath"
      return self.wrath
    else
      return 0
    end
  end
  
  # Returns what Obsidian Portal calls the character's
  # bio. In personae terms, that is the character's
  # description and background.
  def obsidian_bio
    bio = ""
    bio << %{
h5. Description

#{self.description}
    } if self.read_description
    
    bio << %{
h5. Background

#{self.background}
    } if self.read_background

    bio << %{
h5. Deeds

#{self.deeds}
    } if self.read_deeds
    
    bio
  end

  # Returns what Obsidian Portal calls the character's
  # description, which is all of the mechanical bits.
  # I know, it doesn't make sense to me either.
  def obsidian_description
    return "" unless self.read_name

    desc = ""
    desc << %{
|_. Virtue|#{self.virtue}|_. #{self.splat.nature_name if self.read_nature}|#{self.nature.name if self.read_nature}|
|_. Vice|#{self.vice}|_. #{self.splat.subnature_name if self.is_changeling? and self.read_nature}|#{self.subnature.name if self.is_changeling? and self.read_nature}|
|||_. #{self.splat.ideology_name if self.read_ideology}|#{self.ideology.name if self.read_ideology}|
|||_. #{self.splat.clique_name if self.read_clique}|#{self.clique.name if self.read_clique}|
    }

    desc << %{
h5. Attributes

|_. Intelligence:|#{'•' * self.intelligence}|_. Strength:|#{'•' * self.strength}|_. Presence:|#{'•' * self.presence}|
|_. Wits:|#{'•' * self.wits}|_. Dexterity:|#{'•' * self.dexterity}|_. Manipulation:|#{'•' * self.manipulation}|
|_. Resolve:|#{'•' * self.resolve}|_. Stamina:|#{'•' * self.stamina}|_. Composure:|#{'•' * self.composure}|

h5. Skills

|_. Academics:|#{'•' * self.academics}|_. Athletics:|#{'•' * self.athletics}|_. Animal Ken:|#{'•' * self.animal_ken}|
|_. Computer:|#{'•' * self.computer}|_. Brawl:|#{'•' * self.brawl}|_. Empathy:|#{'•' * self.empathy}|
|_. Crafts:|#{'•' * self.crafts}|_. Drive:|#{'•' * self.drive}|_. Expression:|#{'•' * self.expression}|
|_. Investigation:|#{'•' * self.investigation}|_. Firearms:|#{'•' * self.firearms}|_. Intimidation:|#{'•' * self.intimidation}|
|_. Medicine:|#{'•' * self.medicine}|_. Larceny:|#{'•' * self.larceny}|_. Persuasion:|#{'•' * self.persuasion}|
|_. Occult:|#{'•' * self.occult}|_. Stealth:|#{'•' * self.stealth}|_. Socialize:|#{'•' * self.socialize}|
|_. Politics:|#{'•' * self.politics}|_. Survival:|#{'•' * self.survival}|_. Streetwise:|#{'•' * self.streetwise}|
|_. Science:|#{'•' * self.science}|_. Weaponry:|#{'•' * self.weaponry}|_. Subterfuge:|#{'•' * self.subterfuge}|
|_. Skill Specialties:|\\5. #{self.skill_specialties}|

h5. Advantages

|_. Health:|#{'•' * self.health}|_. Willpower:|#{'•' * self.willpower}|
|_. Size:|#{ self.size}|
|_. Initiative:|#{self.initiative}|
|_. Speed:|#{self.speed}|
|_. Defense:|#{self.defense}|
|_. Armor:|#{self.armor}|
|_. Morality:|#{self.morality}|
|_. Power Stat:|#{self.power_stat}|
|_. Fuel:|#{self.max_fuel}|

h5. Merits

#{self.merits}

h5. Equipment

#{self.equipment}
    } if self.read_crunch

    case self.splat.name
    when "Vampire"
      desc << %{
h5. Disciplines

|_. Animalism:|#{'•' * self.animalism}|_. Covenant Disciplines:|
|_. Auspex:|#{'•' * self.auspex}|/9. #{self.covenant_disciplines}|
|_. Celerity:|#{'•' * self.celerity}|
|_. Dominate:|#{'•' * self.dominate}|
|_. Majesty:|#{'•' * self.majesty}|
|_. Nightmare:|#{'•' * self.nightmare}|
|_. Obfuscate:|#{'•' * self.obfuscate}|
|_. Protean:|#{'•' * self.protean}|
|_. Resilience:|#{'•' * self.resilience}|
|_. Vigor:|#{'•' * self.vigor}|}
    when "Werewolf"
      desc << %{
h5. Renown

|_. Purity:|#{'•' * self.purity}|_. Gifts:|
|_. Glory:|#{'•' * self.glory}|/4. #{self.gifts}|
|_. Honor:|#{'•' * self.honor}|
|_. Wisdom:|#{'•' * self.wisdom}|
|_. Cunning:|#{'•' * self.cunning}|}
    when "Mage"
      desc << %{
h5. Arcana

|_. Death:|#{'•' * self.death}|_. Common spells:|
|_. Fate:|#{'•' * self.fate}|/9. #{self.common_spells}|
|_. Forces:|#{'•' * self.forces}|
|_. Life:|#{'•' * self.life}|
|_. Matter:|#{'•' * self.matter}|
|_. Mind:|#{'•' * self.mind}|
|_. Prime:|#{'•' * self.prime}|
|_. Space:|#{'•' * self.space}|
|_. Spirit:|#{'•' * self.spirit}|
|_. Time:|#{'•' * self.time}|}
    when "Promethean"
      desc << %{
h5. Transmutations

#{self.transmutations}}
    when "Changeling"
      desc << %{
h5. Contracts

|_. Dream:|#{'•' * self.dream}|_. Goblin contracts:|
|_. Hearth:|#{'•' * self.hearth}|/17. #{self.goblin_contracts}|
|_. Mirror:|#{'•' * self.mirror}|
|_. Smoke:|#{'•' * self.smoke}|
|_. Artifice:|#{'•' * self.artifice}|
|_. Darkness:|#{'•' * self.darkness}|
|_. Elements:|#{'•' * self.elements}|
|_. Fang and Tooth:|#{'•' * self.fang_and_tooth}|
|_. Stone:|#{'•' * self.stone}|
|_. Vainglory:|#{'•' * self.vainglory}|
|_. Fleeting Spring:|#{'•' * self.fleeting_spring}|
|_. Eternal Spring:|#{'•' * self.eternal_spring}|
|_. Fleeting Summer:|#{'•' * self.fleeting_summer}|
|_. Eternal Summer:|#{'•' * self.eternal_summer}|
|_. Fleeting Autumn:|#{'•' * self.fleeting_autumn}|
|_. Eternal Autumn:|#{'•' * self.eternal_autumn}|
|_. Fleeting Winter:|#{'•' * self.fleeting_winter}|
|_. Eternal Winter:|#{'•' * self.eternal_winter}|}
    when "Geist"
      desc << %{
h5. Manifestations

|_. Boneyard:|#{'•' * self.boneyard}|_. Keys:|
|_. Caul:|#{'•' * self.caul}|/6. #{self.keys}|
|_. Curse:|#{'•' * self.curse}|
|_. Oracle:|#{'•' * self.oracle}|
|_. Marionette:|#{'•' * self.marionette}|
|_. Rage:|#{'•' * self.rage}|
|_. Shroud:|#{'•' * self.shroud}|}
    end if self.read_crunch

    desc << %{

h5. Experience

#{self.experience}
    } if self.read_experience

    desc << %{
h5. Notes

#{self.notes}
    } if self.read_notes

    desc
  end

  # List characters known to the given user
  def self.known_to(user, selected_chronicle=user.selected_chronicle.id)
    user = User.new if user == 0
    characters = Character.find_all_by_chronicle_id(selected_chronicle, :order => "clique_id ASC").collect do |c|
      c if c.show_name_to_user?(user)
    end
    
    characters.delete_if { |c| c == nil }
  end

  # Show the character's name in the url
  def to_param
    "#{self.id}-#{self.name.gsub(/[ '"#%\{\}|\\^~\[\]`]/, '-').gsub(/[.&?\/:;=@]/, '')}"
  end

  private
  # Returns true if the character is owned by the logged in user or if the
  # logged in user is a User.super_user?
  def owned_by_user?(user)
    return false unless user
    user.super_user?(self.chronicle) or self.owner == user
  end
end
