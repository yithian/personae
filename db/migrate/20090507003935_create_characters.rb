class CreateCharacters < ActiveRecord::Migration
  def self.up
    create_table :characters do |t|
      t.string :name
      t.string :path
      t.string :virtue
      t.string :vice
      t.integer :cabal_id, :null => false, :options => "CONSTRAINT fk_character_cabals REFERENCES cabal(id)"
      t.integer :order_id, :null => false, :options => "CONSTRAINT fk_character_order REFERENCES order(id)"
      t.text :description
      t.text :background
      t.integer :intelligence
      t.integer :strength
      t.integer :presence
      t.integer :wits
      t.integer :dexterity
      t.integer :manipulation
      t.integer :resolve
      t.integer :stamina
      t.integer :composure
      t.integer :academics
      t.integer :athletics
      t.integer :animal_ken
      t.integer :computer
      t.integer :brawl
      t.integer :empathy
      t.integer :crafts
      t.integer :drive
      t.integer :expression
      t.integer :investigation
      t.integer :firearms
      t.integer :intimidation
      t.integer :medicine
      t.integer :larceny
      t.integer :persuasion
      t.integer :occult
      t.integer :stealth
      t.integer :socialize
      t.integer :politics
      t.integer :survival
      t.integer :streetwise
      t.integer :science
      t.integer :weaponry
      t.integer :subterfuge
      t.text :skill_specialties
      t.string :health
      t.string :willpower
      t.integer :speed
      t.integer :initiative
      t.integer :defense
      t.integer :armor
      t.integer :wisdom
      t.text :derangements
      t.text :merits
      t.integer :gnosis
      t.integer :death
      t.integer :fate
      t.integer :forces
      t.integer :life
      t.integer :matter
      t.integer :mind
      t.integer :prime
      t.integer :space
      t.integer :spirit
      t.integer :time
      t.text :equipment
      t.text :common_spells

      t.timestamps
    end
  end

  def self.down
    drop_table :characters
  end
end
