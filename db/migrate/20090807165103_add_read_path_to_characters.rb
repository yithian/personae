class AddReadPathToCharacters < ActiveRecord::Migration
  def self.up
    add_column :characters, :read_path, :boolean, :default => false
  end

  def self.down
    remove_column :characters, :read_path
  end
end
