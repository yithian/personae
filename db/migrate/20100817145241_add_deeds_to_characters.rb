class AddDeedsToCharacters < ActiveRecord::Migration
  def self.up
    add_column :characters, :deeds, :text
    add_column :characters, :read_deeds, :boolean, :default => true
  end

  def self.down
    remove_column :characters, :read_deeds
    remove_column :characters, :deeds
  end
end
