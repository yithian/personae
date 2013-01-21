class AddDefaultsToSpiritAttributes < ActiveRecord::Migration
  def change
    change_column_default(:characters, :power, 1)
    change_column_default(:characters, :finesse, 1)
    change_column_default(:characters, :resistance, 1)
  end
end
