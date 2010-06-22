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
    Splat.create(:name => "Mortal", :clique_name => "Clique", :morality_name => "Morality")
    Splat.create(:name => "Mage", :nature_name => "Path", :clique_name => "Cabal", :ideology_name => "Order", :morality_name => "Wisdom", :power_stat_name => "Gnosis", :fuel_name => "Mana")
    
    add_column :characters, "splat_id", :integer, :null => false, :default => Splat.find_by_name('Mage').id, :options => "CONSTRAINT fk_characters_splats      REFERENCES splat(id)"
    add_column :ideologies, "splat_id", :integer, :null => false, :default => Splat.find_by_name('Mage').id, :options => "CONSTRAINT fk_ideologies_splats      REFERENCES splat(id)"
  end

  def self.down
    remove_column :ideologies, "splat_id"
    remove_column :characters, "splat_id"
    drop_table :splats
  end
end
