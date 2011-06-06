class RenameChroniclesUserIdToOwnerId < ActiveRecord::Migration
  def self.up
    rename_column :chronicles, :user_id, :owner_id
  end

  def self.down
    rename_column :chronicles, :owner_id, :user_id
  end
end
