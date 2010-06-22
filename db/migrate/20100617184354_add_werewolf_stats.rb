class AddWerewolfStats < ActiveRecord::Migration
  def self.up
    add_column :characters, "purity", :integer, :default => 0
    add_column :characters, "glory", :integer, :default => 0
    add_column :characters, "honor", :integer, :default => 0
    add_column :characters, "wisdom", :integer, :default => 0
    add_column :characters, "cunning", :integer, :default => 0
    add_column :characters, "gifts", :text
    add_column :characters, "totem", :text
    Ideology.create(:name => "Blood Talons")
    Ideology.create(:name => "Bone Shadows")
    Ideology.create(:name => "Hunters in Darkness")
    Ideology.create(:name => "Iron Masters")
    Ideology.create(:name => "Storm Lords")
    Splat.create(:name => "Werewolf", :nature_name => "Auspice", :clique_name => "Pack", :ideology_name => "Tribe", :morality_name => "Harmony", :power_stat_name => "Primal Urge", :fuel_name => "Essence")
  end

  def self.down
    Splat.find_by_name("Werewolf").delete
    Ideology.find_by_name('Storm Lords').delete
    Ideology.find_by_name('Iron Masters').delete
    Ideology.find_by_name('Hunters in Darkness').delete
    Ideology.find_by_name('Bone Shadows').delete
    Ideology.find_by_name('Blood Talons').delete
    remove_column :characters, 'totem', :text
    remove_column :characters, 'gifts', :text
    remove_column :characters, 'cunning', :integer, :default => 0
    remove_column :characters, 'wisdom', :integer, :default => 0
    remove_column :characters, 'honor', :integer, :default => 0
    remove_column :characters, 'glory', :integer, :default => 0
    remove_column :characters, 'purity', :integer, :default => 0
  end
end
