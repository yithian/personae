class AddPowerFinesseAndResistanceToCharacters < ActiveRecord::Migration
  def change
    add_column :characters, :power, :integer, :default => 0
    add_column :characters, :finesse, :integer, :default => 0
    add_column :characters, :resistance, :integer, :default => 0
    add_column :characters, :numina, :string
  end
end
