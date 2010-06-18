class Character < ActiveRecord::Base
  belongs_to :cabal
  belongs_to :order
  belongs_to :user
  has_many :comments, :dependent => :destroy
  
  PATHS = [ 'Sleeper', 'Acanthus', 'Mastigos', 'Moros', 'Obrimos', 'Thyrsus' ]
  VIRTUES = [ 'Charity', 'Faith', 'Fortitude', 'Hope', 'Justice', 'Prudence', 'Temperance' ]
  VICES = [ 'Envy', 'Gluttony', 'Greed', 'Lust', 'Sloth', 'Pride', 'Wrath' ]
  
  validates_uniqueness_of :name
  validates_numericality_of :intelligence, :strength, :presence, :wits, :dexterity, :manipulation, :resolve, :stamina, :composure, :speed, :initiative, :defense
end
