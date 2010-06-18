class AddOwnerToCabals < ActiveRecord::Migration
  def self.up
    add_column :cabals, :user_id, :integer, :default => 1, :null => false, :options => "CONSTRAINT fk_cabals_users REFERENCES user(id)"
  end

  def self.down
    remove_column :cabals, :user_id
  end
end
