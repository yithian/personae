class AddAdminToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :admin, :boolean, :default => false
    User.update_all("admin = 'true'", "name = 'Storyteller'")
  end

  def self.down
    remove_column :users, :admin
  end
end
