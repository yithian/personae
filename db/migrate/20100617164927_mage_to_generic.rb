class MageToGeneric < ActiveRecord::Migration
  def self.up
    rename_table :cabals, :cliques
    rename_table :orders, :ideologies
    rename_column :characters, "cabal_id", "clique_id"
    rename_column :characters, "read_cabal", "read_clique"
    rename_column :characters, "order_id", "ideology_id"
    rename_column :characters, "read_order", "read_ideology"
    rename_column :characters, "wisdom", "morality"
    rename_column :characters, "read_arcana", "read_powers"
    rename_column :characters, "gnosis", "power_stat"
    rename_column :characters, "mana", "fuel"
    remove_column :characters, "read_spells"
    change_column_default :characters, :power_stat, 1
    change_column_default :characters, :fuel, 7
  end

  def self.down
    add_column :characters, "read_spells", :boolean
    rename_column :characters, "fuel", "mana"
    rename_column :characters, "power_stat", "gnosis"
    rename_column :characters, "read_powers", "read_arcana"
    rename_column :characters, "morality", "wisdom"
    rename_column :characters, "read_ideology", "read_order"
    rename_column :characters, "ideology_id", "order_id"
    rename_column :characters, "read_clique", "read_cabal"
    rename_column :characters, "clique_id", "cabal_id"
    rename_table :ideologies, :orders
    rename_table :cliques, :cabals
  end
end
