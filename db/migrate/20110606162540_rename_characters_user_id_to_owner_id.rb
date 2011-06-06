class RenameCharactersUserIdToOwnerId < ActiveRecord::Migration
  def self.up
    rename_column :characters, :user_id, :owner_id
  end

  def self.down
    rename_column :characters, :owner_id, :user_id
  end
end
