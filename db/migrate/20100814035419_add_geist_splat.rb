class AddGeistSplat < ActiveRecord::Migration
  def self.up
    Splat.create(:name => "Geist", :nature_name => "Threshold", :clique_name => "Krewe", :ideology_name => "Archetype", :morality_name => "Synergy", :power_stat_name => "Psyche", :fuel_name => "Plasm")
    
    Nature.create(:name => "Torn", :splat_id => Splat.find_by_name("Geist").id)
    Nature.create(:name => "Silent", :splat_id => Splat.find_by_name("Geist").id)
    Nature.create(:name => "Prey", :splat_id => Splat.find_by_name("Geist").id)
    Nature.create(:name => "Stricken", :splat_id => Splat.find_by_name("Geist").id)
    Nature.create(:name => "Forgotten", :splat_id => Splat.find_by_name("Geist").id)
    
    Ideology.create(:name => "Bonepicker", :splat_id => Splat.find_by_name("Geist").id)
    Ideology.create(:name => "Celebrant", :splat_id => Splat.find_by_name("Geist").id)
    Ideology.create(:name => "Gatekeeper", :splat_id => Splat.find_by_name("Geist").id)
    Ideology.create(:name => "Mourner", :splat_id => Splat.find_by_name("Geist").id)
    Ideology.create(:name => "Necromancer", :splat_id => Splat.find_by_name("Geist").id)
    Ideology.create(:name => "Pilgrim", :splat_id => Splat.find_by_name("Geist").id)
    Ideology.create(:name => "Reaper", :splat_id => Splat.find_by_name("Geist").id)
    
    add_column :characters, "boneyard", :integer, :default => 0, :null => false
    add_column :characters, "caul", :integer, :default => 0, :null => false
    add_column :characters, "curse", :integer, :default => 0, :null => false
    add_column :characters, "marionette", :integer, :default => 0, :null => false
    add_column :characters, "oracle", :integer, :default => 0, :null => false
    add_column :characters, "rage", :integer, :default => 0, :null => false
    add_column :characters, "shroud", :integer, :default => 0, :null => false
    add_column :characters, "keys", :text
    add_column :characters, "ceremonies", :text
  end

  def self.down
    remove_column :characters, "ceremoncies"
    remove_column :characters, "keys"
    remove_column :characters, "shroud"
    remove_column :characters, "rage"
    remove_column :characters, "oracle"
    remove_column :characters, "marionette"
    remove_column :characters, "curse"
    remove_column :characters, "caul"
    remove_column :characters, "boneyard"
    
    Ideology.find_by_name("Reaper").delete
    Ideology.find_by_name("Pilgrim").delete
    Ideology.find_by_name("Necromancer").delete
    Ideology.find_by_name("Mourner").delete
    Ideology.find_by_name("Gatekeeper").delete
    Ideology.find_by_name("Celebrant").delete
    Ideology.find_by_name("Bonepicker").delete
    
    Nature.find_by_name("Forgotte").delete
    Nature.find_by_name("Stricken").delete
    Nature.find_by_name("Prey").delete
    Nature.find_by_name("Silent").delete
    Nature.find_by_name("Torn").delete
    
    Splat.find_by_name("Geist").delete
  end
end
