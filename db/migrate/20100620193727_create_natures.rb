class CreateNatures < ActiveRecord::Migration
  def self.up
    create_table "natures" do |t|
      t.string "name"
      t.integer "splat_id", :null => false, :default => Splat.find_by_name("Mage"), :options => "CONSTRAINT fk_nature_splats REFERENCES splat(id)"
    end
    
    Nature.create(:name => "Mortal", :splat_id => Splat.find_by_name("Mortal").id)
    Nature.create(:name => "Acanthus", :splat_id => Splat.find_by_name("Mage").id)
    Nature.create(:name => "Mastigos", :splat_id => Splat.find_by_name("Mage").id)
    Nature.create(:name => "Moros", :splat_id => Splat.find_by_name("Mage").id)
    Nature.create(:name => "Obrimos", :splat_id => Splat.find_by_name("Mage").id)
    Nature.create(:name => "Thyrsus", :splat_id => Splat.find_by_name("Mage").id)
    Nature.create(:name => "Rahu", :splat_id => Splat.find_by_name("Werewolf").id)
    Nature.create(:name => "Cahalith", :splat_id => Splat.find_by_name("Werewolf").id)
    Nature.create(:name => "Elodoth", :splat_id => Splat.find_by_name("Werewolf").id)
    Nature.create(:name => "Ithaeur", :splat_id => Splat.find_by_name("Werewolf").id)
    Nature.create(:name => "Irraka", :splat_id => Splat.find_by_name("Werewolf").id)
    
    rename_column :characters, "read_path", "read_nature"
    add_column :characters, "nature_id", :integer, :null => false, :default => Nature.find_by_name("Mortal").id, :options => "CONSTRAINT fk_character_natures REFERENCES nature(id)"
    
    Character.update_all("nature_id = 2", "path = 'Acanthus'")
    Character.update_all("nature_id = 3", "path = 'Mastigos'")
    Character.update_all("nature_id = 4", "path = 'Moros'")
    Character.update_all("nature_id = 5", "path = 'Obrimos'")
    Character.update_all("nature_id = 6", "path = 'Thyrsus'")
    
    remove_column :characters, "path"
  end

  def self.down
    add_column :characters, "path", :string

    Character.update_all("path = 'Sleeper'", "nature_id = 1")
    Character.update_all("path = 'Acanthus'", "nature_id = 2")
    Character.update_all("path = 'Mastigos'", "nature_id = 3")
    Character.update_all("path = 'Moros'", "nature_id = 4")
    Character.update_all("path = 'Obrimos'", "nature_id = 5")
    Character.update_all("path = 'Thyrsus'", "nature_id = 6")

    remove_column :characters, :nature_id
    rename_column :characters, "read_nature", "read_path"
    drop_table :natures
  end
end
