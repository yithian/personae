class AddVampireStats < ActiveRecord::Migration
  def self.up
    Splat.create(:name => "Vampire", :nature_name => "Clan", :clique_name => "Coterie", :ideology_name => "Covenant", :morality_name => "Humanity", :power_stat_name => "Blood Potency", :fuel_name => "Vitae")

    Nature.create(:name => "Daeva", :splat_id => Splat.find_by_name("Vampire").id)
    Nature.create(:name => "Gangrel", :splat_id => Splat.find_by_name("Vampire").id)
    Nature.create(:name => "Mekhet", :splat_id => Splat.find_by_name("Vampire").id)
    Nature.create(:name => "Nosferatu", :splat_id => Splat.find_by_name("Vampire").id)
    Nature.create(:name => "Ventrue", :splat_id => Splat.find_by_name("Vampire").id)

    Ideology.create(:name => "Carthian Movement", :splat_id => Splat.find_by_name("Vampire").id)
    Ideology.create(:name => "Circle of the Crone", :splat_id => Splat.find_by_name("Vampire").id)
    Ideology.create(:name => "Invictus", :splat_id => Splat.find_by_name("Vampire").id)
    Ideology.create(:name => "Lancae Sanctum", :splat_id => Splat.find_by_name("Vampire").id)
    Ideology.create(:name => "Ordo Dracul", :splat_id => Splat.find_by_name("Vampire").id)
    Ideology.create(:name => "Unaligned", :splat_id => Splat.find_by_name("Vampire").id)
    Ideology.create(:name => "Belial's Brood", :splat_id => Splat.find_by_name("Vampire").id)
    Ideology.create(:name => "VII", :splat_id => Splat.find_by_name("Vampire").id)

    add_column :characters, "animalism", :integer, :default => 0
    add_column :characters, "auspex", :integer, :default => 0
    add_column :characters, "celerity", :integer, :default => 0
    add_column :characters, "coils of the dragon", :integer, :default => 0
    add_column :characters, "cruac", :integer, :default => 0
    add_column :characters, "dominate", :integer, :default => 0
    add_column :characters, "majesty", :integer, :default => 0
    add_column :characters, "nightmare", :integer, :default => 0
    add_column :characters, "protean", :integer, :default => 0
    add_column :characters, "obfuscate", :integer, :default => 0
    add_column :characters, "theban sorcery", :integer, :default => 0
    add_column :characters, "vigor", :integer, :default => 0
  end

  def self.down
    remove_column :characters, "vigor"
    remove_column :characters, "theban sorcery"
    remove_column :characters, "obfuscate"
    remove_column :characters, "protean"
    remove_column :characters, "nightmare"
    remove_column :characters, "majesty"
    remove_column :characters, "dominate"
    remove_column :characters, "cruac"
    remove_column :characters, "coils of the dragon"
    remove_column :characters, "celerity"
    remove_column :characters, "auspex"
    remove_column :characters, "animalism"

    Ideology.find_by_name("VII").delete
    Ideology.find_by_name("Belial's Brood").delete
    Ideology.find_by_name("Unaligned").delete
    Ideology.find_by_name("Ordo Dracul").delete
    Ideology.find_by_name("Lancae Sanctum").delete
    Ideology.find_by_name("Invictus").delete
    Ideology.find_by_name("Circle of the Crone").delete
    Ideology.find_by_name("Carthian Movement").delete

    Nature.find_by_name("Ventrue").delete
    Nature.find_by_name("Nosferatu").delete
    Nature.find_by_name("Mekhet").delete
    Nature.find_by_name("Gangrel").delete
    Nature.find_by_name("Daeva").delete

    Splat.find_by_name("Vampire").delete
  end
end
