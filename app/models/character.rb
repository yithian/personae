class Character < ActiveRecord::Base
  belongs_to :clique
  belongs_to :ideology
  belongs_to :splat 
  belongs_to :user
  has_many :comments, :dependent => :destroy
  
  SPLATS = [ 'Mortal', 'Acanthus', 'Mastigos', 'Moros', 'Obrimos', 'Thyrsus', 'Rahu', 'Cahalith', 'Elodoth', 'Ithaeur', 'Irraka' ]
  VIRTUES = [ 'Charity', 'Faith', 'Fortitude', 'Hope', 'Justice', 'Prudence', 'Temperance' ]
  VICES = [ 'Envy', 'Gluttony', 'Greed', 'Lust', 'Sloth', 'Pride', 'Wrath' ]
  
  validates_uniqueness_of :name
  validates_numericality_of :intelligence, :strength, :presence, :wits, :dexterity, :manipulation, :resolve, :stamina, :composure, :speed, :initiative, :defense
end
