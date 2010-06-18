class AddManaToCharacters < ActiveRecord::Migration
  def self.up
    add_column :characters, "mana", :integer, :default => 10
  end

  def self.down
    remove_column :characters, "mana"
  end
end
