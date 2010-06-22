class CreateSplats < ActiveRecord::Migration
  #  When adding new splats, add new rows to this table in a later migration
  def self.up
    create_table :splats do |t|
      t.string :name
      t.string :nature_name
      t.string :clique_name
      t.string :ideology_name

      t.timestamps
    end
    Splat.create(:name => "Mortal", :clique_name => "Clique")
    Splat.create(:name => "Mage", :nature_name => "Path", :clique_name => "Cabal", :ideology_name => "Order")
  end

  def self.down
    drop_table :splats
  end
end
