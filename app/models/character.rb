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

  self.per_page = 30

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
  validates :integrity, :presence => true, :numericality => {:greater_than_or_equal_to => 0}
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

  # Returns true if the character is a ghost or spirit or anything that uses that template
  def is_spirit?
    self.splat.name == "Spirit"
  end

  # Returns true if the character is a mummy.
  def is_mummy?
    self.splat.name == "Mummy"
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

  # List characters known to the given user
  def self.known_to(user, selected_chronicle=user.selected_chronicle.id)
    characters = Chronicle.find_by_id(selected_chronicle).characters.collect do |c|
      a = Ability.new(user)
      c if a.can? :read, c
    end

    characters.delete_if { |c| c.nil? }
  end

  # Show the character's name in the url
  def to_param
    "#{self.id}-#{self.name.gsub(/[ '"#%\{\}|\\^~\[\]`]/, '-').gsub(/[.&?\/:;=@]/, '')}"
  end
  def markdown_description
    renderer = Rollable.new(self, hard_wrap: true, filter_html: true)
    Redcarpet::Markdown.new(renderer).render(self.description).html_safe
  end

  def get_stat(stat)
    begin
      return self.send(stat.downcase)
    rescue NoMethodError
      return 0
    end
  end

  private
  # Returns true if the character is owned by the logged in user or if the
  # logged in user is a User.super_user?
  def owned_by_user?(user)
    return false unless user
    user.super_user?(self.chronicle) or self.owner == user
  end


end
