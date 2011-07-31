class AddObsidianInfoToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :obsidian_user_id, :string
    add_column :users, :obsidian_user_name, :string
  end

  def self.down
    remove_column :users, :obsidian_user_name
    remove_column :users, :obsidian_user_id
  end
end
