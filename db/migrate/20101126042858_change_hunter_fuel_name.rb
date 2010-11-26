class ChangeHunterFuelName < ActiveRecord::Migration
  def self.up
    Splat.update_all("fuel_name = 'Fuel'", "name = 'Hunter'")
  end

  def self.down
  end
end
