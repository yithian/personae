class AddCurrentFuelToCharacters < ActiveRecord::Migration
  def self.up
    rename_column :characters, :fuel, :max_fuel
    add_column :characters, :current_fuel, :integer, :default => 7
  end

  def self.down
    remove_column :characters, :current_fuel
    rename_column :characters, :max_fuel, :fuel
  end
end
