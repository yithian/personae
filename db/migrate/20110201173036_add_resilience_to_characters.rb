class AddResilienceToCharacters < ActiveRecord::Migration
  def self.up
    add_column :characters, :resilience, :integer, :default => 0, :null => false
  end

  def self.down
    remove_column :characters, :resilience
  end
end
