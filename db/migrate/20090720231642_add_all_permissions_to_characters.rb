class AddAllPermissionsToCharacters < ActiveRecord::Migration
  def self.up
    remove_column :characters, "user_write"
    rename_column :characters, "user_read", "read_name"
    add_column :characters, "read_description", :boolean, :default => false
    add_column :characters, "read_background", :boolean, :default => false
    add_column :characters, "read_attributes", :boolean, :default => false
    add_column :characters, "read_skills", :boolean, :default => false
    add_column :characters, "read_advantages", :boolean, :default => false
    add_column :characters, "read_merits", :boolean, :default => false
    add_column :characters, "read_arcana", :boolean, :default => false
    add_column :characters, "read_equipment", :boolean, :default => false
    add_column :characters, "read_spells", :boolean, :default => false
    
    rename_column :cabals, "user_read", "read"
    rename_column :cabals, "user_write", "write"
    
    rename_column :orders, "user_read", "read"
  end

  def self.down
    rename_column :orders, "read", "user_read"
    
    rename_column :cabals, "write", "user_write"
    rename_column :cabals, "read", "user_read"
    
    remove_column :characters, "read_spells"
    remove_column :characters, "read_equipment"
    remove_column :characters, "read_arcana"
    remove_column :characters, "read_merits"
    remove_column :characters, "read_advantages"
    remove_column :characters, "read_skills"
    remove_column :characters, "read_attributes"
    remove_column :characters, "read_background"
    remove_column :characters, "read_description"
    rename_column :characters, "read_name", "user_read"
    add_column :characters, "user_write", :boolean, :default => false
  end
end
