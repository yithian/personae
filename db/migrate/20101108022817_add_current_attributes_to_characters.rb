class AddCurrentAttributesToCharacters < ActiveRecord::Migration
  def self.up
    add_column :characters, :current_health, :string
    change_column :characters, :health, :integer
    add_column :characters, :current_willpower, :string
    change_column :characters, :willpower, :integer
  end

  def self.down
    remove_column :characters, :current_willpower
    change_column :characters, :health, :string
    remove_column :characters, :current_health
    change_column :characters, :willpower, :integer
  end
end
