class AddIndexesToCharacters < ActiveRecord::Migration
  def change
    add_index :characters, :chronicle_id
    add_index :cliques, :chronicle_id
  end
end
