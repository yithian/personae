class AddTacticsToCharacters < ActiveRecord::Migration
  def change
    add_column :characters, :tactics, :text
  end
end
