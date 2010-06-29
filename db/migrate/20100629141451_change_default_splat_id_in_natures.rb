class ChangeDefaultSplatIdInNatures < ActiveRecord::Migration
  def self.up
    change_column_default :natures, "splat_id", Splat.find_by_name("Mortal")
  end

  def self.down
    change_column_default :natures, "splat_id", Splat.find_by_name("Mage")
  end
end
