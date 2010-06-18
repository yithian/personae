class AddDefaultsToCharacters < ActiveRecord::Migration
  def self.up
    change_column_default :characters, :intelligence, 1
    change_column_default :characters, :wits, 1
    change_column_default :characters, :resolve, 1
    change_column_default :characters, :strength, 1
    change_column_default :characters, :dexterity, 1
    change_column_default :characters, :stamina, 1
    change_column_default :characters, :presence, 1
    change_column_default :characters, :manipulation, 1
    change_column_default :characters, :composure, 1
    change_column_default :characters, :academics, 0
    change_column_default :characters, :computer, 0
    change_column_default :characters, :crafts, 0
    change_column_default :characters, :investigation, 0
    change_column_default :characters, :medicine, 0
    change_column_default :characters, :occult, 0
    change_column_default :characters, :politics, 0
    change_column_default :characters, :science, 0
    change_column_default :characters, :athletics, 0
    change_column_default :characters, :brawl, 0
    change_column_default :characters, :drive, 0
    change_column_default :characters, :firearms, 0
    change_column_default :characters, :larceny, 0
    change_column_default :characters, :stealth, 0
    change_column_default :characters, :survival, 0
    change_column_default :characters, :weaponry, 0
    change_column_default :characters, :animal_ken, 0
    change_column_default :characters, :empathy, 0
    change_column_default :characters, :expression, 0
    change_column_default :characters, :intimidation, 0
    change_column_default :characters, :persuasion, 0
    change_column_default :characters, :socialize, 0
    change_column_default :characters, :streetwise, 0
    change_column_default :characters, :subterfuge, 0
    change_column_default :characters, :speed, 5
    change_column_default :characters, :health, 6
    change_column_default :characters, :willpower, 2
    change_column_default :characters, :wisdom, 7
    change_column_default :characters, :gnosis, 1
  end

  def self.down
  end
end
