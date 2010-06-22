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
  end

  def self.down
    drop_table :splats
  end
end
