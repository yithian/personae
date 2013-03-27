class NuminaToText < ActiveRecord::Migration
  def up
    change_column :characters, :numina, :text
  end

  def down
    change_column :characters, :numina, :string
  end
end
