class AddMissingDefaultsToCharacters < ActiveRecord::Migration
  def self.up
    change_column_default :characters, "armor", 0
    change_column_default :characters, "death", 0
    change_column_default :characters, "fate", 0
    change_column_default :characters, "forces", 0
    change_column_default :characters, "life", 0
    change_column_default :characters, "matter", 0
    change_column_default :characters, "mind", 0
    change_column_default :characters, "prime", 0
    change_column_default :characters, "space", 0
    change_column_default :characters, "spirit", 0
    change_column_default :characters, "time", 0
    
    Character.update_all("armor = 0", "armor IS NULL")
    Character.update_all("death = 0", "death IS NULL")
    Character.update_all("fate = 0", "fate IS NULL")
    Character.update_all("forces = 0", "forces IS NULL")
    Character.update_all("life = 0", "life IS NULL")
    Character.update_all("matter = 0", "matter IS NULL")
    Character.update_all("mind = 0", "mind IS NULL")
    Character.update_all("prime = 0", "prime IS NULL")
    Character.update_all("space = 0", "space IS NULL")
    Character.update_all("spirit = 0", "spirit IS NULL")
    Character.update_all("time = 0", "time IS NULL")
  end

  def self.down
  end
end
