class CreateSplats < ActiveRecord::Migration
  #  When adding new splats, add new rows to this table in a later migration
  def self.up
    create_table :splats do |t|
      t.string :name
      t.string :nature_name
      t.string :clique_name
      t.string :ideology_name
      t.string :morality_name
      t.string :power_stat_name
      t.string :fuel_name

      t.timestamps
    end
    Splat.create(:name => "Mortal", :nature_name => "Nature", :clique_name => "Clique", :ideology_name => "Ideology", :morality_name => "Morality", :power_stat_name => "Power Stat", :fuel_name => "Fuel")
    Splat.create(:name => "Mage", :nature_name => "Path", :clique_name => "Cabal", :ideology_name => "Order", :morality_name => "Wisdom", :power_stat_name => "Gnosis", :fuel_name => "Mana")
    
    add_column :characters, "splat_id", :integer, :null => false, :default => Splat.find_by_name("Mortal").id, :options => "CONSTRAINT fk_character_splats      REFERENCES splat(id)"
    Character.update_all("splat_id = 2", "path != 'Sleeper'")
    
    add_column :ideologies, "splat_id", :integer, :null => false, :default => Splat.find_by_name("Mortal").id, :options => "CONSTRAINT fk_ideologies_splats      REFERENCES splat(id)"
    Ideology.create(:name => "Mortal", :splat_id => Splat.find_by_name("Mortal").id)
    Ideology.update_all("splat_id = 2", "name != 'Mortal'")
  end

  def self.down
    remove_column :ideologies, "splat_id"
    remove_column :characters, "splat_id"
    drop_table :splats
  end
end
