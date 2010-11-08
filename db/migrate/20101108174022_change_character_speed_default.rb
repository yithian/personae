class ChangeCharacterSpeedDefault < ActiveRecord::Migration
  def self.up
    change_column_default :characters, :speed, 7
  end

  def self.down
  end
end
