class ChangeMortalPowerStatToConviction < ActiveRecord::Migration
  def self.up
    Splat.update_all("power_stat_name = 'Conviction'", "name = 'Mortal'")
  end

  def self.down
  end
end
