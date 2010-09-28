class ChangeMortalPowerStatToConviction < ActiveRecord::Migration
  def self.up
    Splat.find_by_name("Mortal") do |s|
      s.power_stat_name = "Conviction"
    end
  end

  def self.down
  end
end
