class AddOwnerToCharacters < ActiveRecord::Migration
  def self.up
    add_column :characters, "user_id", :integer, :options => "CONSTRAINT fk_characters_users references user(id)"
  end

  def self.down
    remove_column :characters, "user_id"
  end
end
