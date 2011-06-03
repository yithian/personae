class AddUserIdToChronicles < ActiveRecord::Migration
  def self.up
    add_column :chronicles, :user_id, :integer, :options => "fk_chronicles_user REFERENCES user(id)", :default => User.find_by_name("Storyteller"), :null => false
    rename_column :users, :chronicle_id, :selected_chronicle_id
  end

  def self.down
    rename_column :users, :selected_chronicle_id, :chronicle_id
    remove_column :chronicles, :user_id
  end
end
