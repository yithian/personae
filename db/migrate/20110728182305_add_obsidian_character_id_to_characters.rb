class AddObsidianCharacterIdToCharacters < ActiveRecord::Migration
  def self.up
    add_column :characters, :obsidian_character_id, :string
  end

  def self.down
    remove_column :characters, :obsidian_character_id
  end
end
