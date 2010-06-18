class AddOwnershipToTables < ActiveRecord::Migration
  def self.up
    add_column :characters, "user_read", :boolean, :default => false
    add_column :characters, "user_write", :boolean, :default => false
    add_column :cabals, "user_read", :boolean, :default => true
    add_column :cabals, "user_write", :boolean, :default => false
    add_column :orders, "user_read", :boolean, :default => true
  end

  def self.down
    remove_column :characters, "user_read"
    remove_column :characters, "user_write"
    remove_column :cabals, "user_read"
    remove_column :cabals, "user_write"
    remove_column :orders, "user_read"
  end
end
