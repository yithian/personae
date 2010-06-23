class AddWerewolfStats < ActiveRecord::Migration
  def self.up
    Splat.create(:name => "Werewolf", :nature_name => "Auspice", :clique_name => "Pack", :ideology_name => "Tribe", :morality_name => "Harmony", :power_stat_name => "Primal Urge", :fuel_name => "Essence")
    Ideology.create(:name => "Blood Talons", :splat_id => Splat.find_by_name("Werewolf").id)
    Ideology.create(:name => "Bone Shadows", :splat_id => Splat.find_by_name("Werewolf").id)
    Ideology.create(:name => "Hunters in Darkness", :splat_id => Splat.find_by_name("Werewolf").id)
    Ideology.create(:name => "Iron Masters", :splat_id => Splat.find_by_name("Werewolf").id)
    Ideology.create(:name => "Storm Lords", :splat_id => Splat.find_by_name("Werewolf").id)
    Ideology.create(:name => "Ghost Wolf", :splat_id => Splat.find_by_name("Werewolf").id)
    Ideology.create(:name => "Fire-Touched", :splat_id => Splat.find_by_name("Werewolf").id)
    Ideology.create(:name => "Ivory Claws", :splat_id => Splat.find_by_name("Werewolf").id)
    Ideology.create(:name => "Predator Kings", :splat_id => Splat.find_by_name("Werewolf").id)
    add_column :characters, "purity", :integer, :default => 0
    add_column :characters, "glory", :integer, :default => 0
    add_column :characters, "honor", :integer, :default => 0
    add_column :characters, "wisdom", :integer, :default => 0
    add_column :characters, "cunning", :integer, :default => 0
    add_column :characters, "gifts", :text
    add_column :characters, "totem", :text
  end

  def self.down
    remove_column :characters, "totem", :text
    remove_column :characters, "gifts", :text
    remove_column :characters, "cunning", :integer, :default => 0
    remove_column :characters, "wisdom", :integer, :default => 0
    remove_column :characters, "honor", :integer, :default => 0
    remove_column :characters, "glory", :integer, :default => 0
    remove_column :characters, "purity", :integer, :default => 0
    Ideology.find_by_name("Predator Kings").delete
    Ideology.find_by_name("Ivory Claws").delete
    Ideology.find_by_name("Fire-Touched").delete
    Ideology.find_by_name("Ghost Wolf").delete
    Ideology.find_by_name("Storm Lords").delete
    Ideology.find_by_name("Iron Masters").delete
    Ideology.find_by_name("Hunters in Darkness").delete
    Ideology.find_by_name("Bone Shadows").delete
    Ideology.find_by_name("Blood Talons").delete
    Splat.find_by_name("Werewolf").delete
  end
end
