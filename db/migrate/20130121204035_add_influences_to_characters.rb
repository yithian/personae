class AddInfluencesToCharacters < ActiveRecord::Migration
  def change
    add_column :characters, :influences, :string
  end
end
