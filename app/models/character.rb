class Character < ActiveRecord::Base
  belongs_to :clique
  belongs_to :ideology
  belongs_to :nature
  belongs_to :splat 
  belongs_to :user
  has_many :comments, :dependent => :destroy
  
  VIRTUES = [ 'Charity', 'Faith', 'Fortitude', 'Hope', 'Justice', 'Prudence', 'Temperance' ]
  VICES = [ 'Envy', 'Gluttony', 'Greed', 'Lust', 'Sloth', 'Pride', 'Wrath' ]
  
  validates_uniqueness_of :name
  validates_numericality_of :clique_id, :ideology_id, :splat_id, :nature_id, :intelligence, :strength, :presence, :wits, :dexterity, :manipulation, :resolve, :stamina, :composure, :academics, :athletics, :animal_ken, :computer, :brawl, :empathy, :crafts, :drive, :expression, :investigation, :firearms, :intimidation, :medicine, :larceny, :persuasion, :occult, :stealth, :socialize, :politics, :survival, :streetwise, :science, :weaponry, :subterfuge, :speed, :initiative, :defense, :armor, :morality, :power_stat, :fuel, :death, :fate, :forces, :life, :matter, :mind, :prime, :space, :spirit, :time, :purity, :glory, :honor, :wisdom, :cunning, :animalism, :auspex, :celerity, :dominate, :majesty, :nightmare, :protean, :obfuscate, :vigor
end
