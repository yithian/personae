class MageToGeneric < ActiveRecord::Migration
  def self.up
    rename_table :cabals, :cliques
    rename_table :orders, :ideologies
    add_column :ideologies, "splat_id", :integer, :null => false, :options => "CONSTRAINT fk_ideologies_splats REFERENCES splat(id)"
    rename_column :characters, "cabal_id", "clique_id"
    rename_column :characters, "read_cabal", "read_clique"
    rename_column :characters, "order_id", "ideology_id"
    rename_column :characters, "read_order", "read_ideology"
    rename_column :characters, "wisdom", "morality"
    change_column_default :characters, :gnosis, 0
    change_column_default :characters, :mana, 7
    add_column :characters, "splat_id", :integer, :default => 2, :options => "CONSTRAINT fk_characters_splats REFERENCES splat(id)"
  end

  def self.down
    remove_column :characters, "splat"
    rename_column :characters, "morality", "wisdom"
    rename_column :characters, "read_ideology", "read_order"
    rename_column :characters, "ideology_id", "order_id"
    rename_column :characters, "read_clique", "read_cabal"
    rename_column :characters, "clique_id", "cabal_id"
    remove_column :ideologies, "splat_id"
    rename_table :ideologies, :orders
    rename_table :cliques, :cabals
  end
end
