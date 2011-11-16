class AddPcToCharacters < ActiveRecord::Migration
  def change
    add_column :characters, :pc, :boolean, :default => false
  end
end
