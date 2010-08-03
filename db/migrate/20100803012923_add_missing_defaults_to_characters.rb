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
    
    Character.find_by_armor(nil) do |c|
      c.armor = 0
      c.save_with_validation(perform_validation = false)
    end
    
    Character.find_by_death(nil) do |c|
      c.death = 0
      c.save_with_validation(perform_validation = false)
    end
    
    Character.find_by_fate(nil) do |c|
      c.fate = 0
      c.save_with_validation(perform_validation = false)
    end
    
    Character.find_by_forces(nil) do |c|
      c.forces = 0
      c.save_with_validation(perform_validation = false)
    end
    
    Character.find_by_life(nil) do |c|
      c.life = 0
      c.save_with_validation(perform_validation = false)
    end
    
    Character.find_by_matter(nil) do |c|
      c.matter = 0
      c.save_with_validation(perform_validation = false)
    end
    
    Character.find_by_mind(nil) do |c|
      c.mind = 0
      c.save_with_validation(perform_validation = false)
    end
    
    Character.find_by_prime(nil) do |c|
      c.prime = 0
      c.save_with_validation(perform_validation = false)
    end
    
    Character.find_by_space(nil) do |c|
      c.space = 0
      c.save_with_validation(perform_validation = false)
    end
    
    Character.find_by_spirit(nil) do |c|
      c.spirit = 0
      c.save_with_validation(perform_validation = false)
    end
    
    Character.find_by_time(nil) do |c|
      c.time = 0
      c.save_with_validation(perform_validation = false)
    end
  end

  def self.down
  end
end
