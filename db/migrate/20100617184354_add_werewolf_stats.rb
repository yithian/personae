class AddWerewolfStats < ActiveRecord::Migration
  def self.up
    add_column :characters, "primal_urge", :integer, :default => 0
    add_column :characters, "read_primal_urge", :boolean, :default => false
    add_column :characters, "essence", :integer, :default => 7
    add_column :characters, "read_essence", :boolean, :default => false
    add_column :characters, "purity", :integer, :default => 0
    add_column :characters, "glory", :integer, :default => 0
    add_column :characters, "honor", :integer, :default => 0
    add_column :characters, "wisdom", :integer, :default => 0
    add_column :characters, "cunning", :integer, :default => 0
    add_column :characters, "read_renown", :boolean, :default => false
    add_column :characters, "gifts", :text
    add_column :characters, "read_gifts", :boolean, :default => false
    add_column :characters, "totem", :text
    add_column :characters, "read_totem", :boolean, :default => false
    Ideology.create(:name => "Blood Talons")
    Ideology.create(:name => "Bone Shadows")
    Ideology.create(:name => "Hunters in Darkness")
    Ideology.create(:name => "Iron Masters")
    Ideology.create(:name => "Storm Lords")
    Splat.create(:type => "Werewolf")
  end

  def self.down
    Ideology.find_by_name('Storm Lords').delete
    Ideology.find_by_name('Iron Masters').delete
    Ideology.find_by_name('Hunters in Darkness').delete
    Ideology.find_by_name('Bone Shadows').delete
    Ideology.find_by_name('Blood Talons').delete
    remove_column :characters, 'read_totem', :boolean, :default => false
    remove_column :characters, 'totem', :text
    remove_column :characters, 'read_gifts', :boolean, :default => false
    remove_column :characters, 'gifts', :text
    remove_column :characters, 'read_renown', :boolean, :default => false
    remove_column :characters, 'cunning', :integer, :default => 0
    remove_column :characters, 'wisdom', :integer, :default => 0
    remove_column :characters, 'honor', :integer, :default => 0
    remove_column :characters, 'glory', :integer, :default => 0
    remove_column :characters, 'purity', :integer, :default => 0
    remove_column :characters, 'read_essence', :boolean, :default => false
    remove_column :characters, 'essence', :integer, :default => 7
    remove_column :characters, 'read_primal_urge', :boolean, :default => false
    remove_column :characters, 'primal_urge', :integer, :default => 0
  end
end
