class AddReadAspirationsToCharacters < ActiveRecord::Migration
  def change
    add_column :characters, :read_aspirations, :boolean, :default => false
  end
end
