class RenameCliquesUserIdToOwnerId < ActiveRecord::Migration
  def self.up
    rename_column :cliques, :user_id, :owner_id
  end

  def self.down
    rename_column :cliques, :owner_id, :user_id
  end
end
