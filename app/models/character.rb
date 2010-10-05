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
end
