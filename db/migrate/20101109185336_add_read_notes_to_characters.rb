class AddReadNotesToCharacters < ActiveRecord::Migration
  def self.up
    add_column :characters, :read_notes, :boolean, :default => false
  end

  def self.down
    remove_column :characters, :read_notes
  end
end
