class AddSizeToCharacters < ActiveRecord::Migration
  def self.up
    add_column :characters, :size, :integer, :default => 5, :null => false
  end

  def self.down
    remove_column :characters, :size
  end
end
