class AddConceptToCharacters < ActiveRecord::Migration
  def self.up
    add_column :characters, :concept, :string, :default => ''
  end

  def self.down
    remove_column :characters, :concept
  end
end
