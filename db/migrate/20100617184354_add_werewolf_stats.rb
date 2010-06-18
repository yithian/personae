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
    add_column :characters, "totem" :text
    add_column :characters, "read_totem", :boolean, :default => false
    Ideology.create(:name => "Blood Talons")
    Ideology.create(:name => "Bone Shadows")
    Ideology.create(:name => "Hunters in Darkness")
    Ideology.create(:name => "Iron Masters")
    Ideology.create(:name => "Storm Lords")
  end

  def self.down
    add_column :characters, "read_totem", :boolean, :default => false
    add_column :characters, "totem" :text
    add_column :characters, "read_gifts", :boolean, :default => false
    add_column :characters, "gifts", :text
    add_column :characters, "read_renown", :boolean, :default => false
    add_column :characters, "cunning", :integer, :default => 0
    add_column :characters, "wisdom", :integer, :default => 0
    add_column :characters, "honor", :integer, :default => 0
    add_column :characters, "glory", :integer, :default => 0
    add_column :characters, "purity", :integer, :default => 0
    add_column :characters, "read_essence", :boolean, :default => false
    add_column :characters, "essence", :integer, :default => 7
    add_column :characters, "read_primal_urge", :boolean, :default => false
    add_column :characters, "primal_urge", :integer, :default => 0
  end
end
