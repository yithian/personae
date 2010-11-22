class VirtueValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless [ 'Charity', 'Faith', 'Fortitude', 'Hope', 'Justice', 'Prudence', 'Temperance' ].include?(value)
      record.errors[attribute] << "#{value} is an invalid virtue"
    end
  end
end

class ViceValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless [ 'Envy', 'Gluttony', 'Greed', 'Lust', 'Sloth', 'Pride', 'Wrath' ].include?(value)
      record.errors[attribute] << "#{value} is an invalid vice"
    end
  end
end

class Character < ActiveRecord::Base
  belongs_to :clique
  belongs_to :ideology
  belongs_to :nature
  belongs_to :splat 
  belongs_to :user
  belongs_to :chronicle
  has_many :comments, :dependent => :destroy
  
  VIRTUES = [ 'Charity', 'Faith', 'Fortitude', 'Hope', 'Justice', 'Prudence', 'Temperance' ]
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
  validates :fuel, :numericality => true
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

  def can_edit_as_user?(user_id)
    owned_by_user?(user_id)
  end
  
  def can_destroy_as_user?(user_id)
    owned_by_user?(user_id)
  end
  
  def show_name_to_user?(user_id)
    owned_by_user?(user_id) or self.read_name
  end
  
  def show_nature_to_user?(user_id)
    owned_by_user?(user_id) or self.read_nature
  end
  
  def show_clique_to_user?(user_id)
    owned_by_user?(user_id) or self.read_clique
  end
  
  def show_ideology_to_user?(user_id)
    owned_by_user?(user_id) or self.read_ideology
  end
  
  def show_description_to_user?(user_id)
    owned_by_user?(user_id) or self.read_description
  end
  
  def show_background_to_user?(user_id)
    owned_by_user?(user_id) or self.read_background
  end
  
  def show_deeds_to_user?(user_id)
    owned_by_user?(user_id) or self.read_deeds
  end
  
  def show_attributes_to_user?(user_id)
    owned_by_user?(user_id) or self.read_attributes
  end
  
  def show_skills_to_user?(user_id)
    owned_by_user?(user_id) or self.read_skills
  end
  
  def show_advantages_to_user?(user_id)
    owned_by_user?(user_id) or self.read_advantages
  end
  
  def show_merits_to_user?(user_id)
    owned_by_user?(user_id) or self.read_merits
  end
  
  def show_powers_to_user?(user_id)
    owned_by_user?(user_id) or self.read_powers
  end
  
  def show_equipment_to_user?(user_id)
    owned_by_user?(user_id) or self.read_equipment
  end
  
  def show_experience_to_user?(user_id)
    owned_by_user?(user_id) or self.read_experience
  end

  def show_notes_to_user?(user_id)
    owned_by_user?(user_id) or self.read_notes
  end
  
  def is_mortal?
    self.splat.name == "Mortal" or self.splat.name == "Hunter"
  end
  
  def is_mage?
    self.splat.name == "Mage"
  end
  
  def is_werewolf?
    self.splat.name == "Werewolf"
  end

  def is_vampire?
    self.splat.name == "Vampire"
  end

  def is_promethean?
    self.splat.name == "Promethean"
  end

  def is_changeling?
    self.splat.name == "Changeling"
  end
  
  def is_geist?
    self.splat.name == "Geist"
  end

  private
  def owned_by_user?(user_id)
    user_id == User.find_by_name("Storyteller").id or self.user_id == user_id
  end
end
