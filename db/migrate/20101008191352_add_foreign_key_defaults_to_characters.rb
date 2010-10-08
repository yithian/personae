class AddForeignKeyDefaultsToCharacters < ActiveRecord::Migration
  def self.up
    change_column_default :characters, "virtue", "Charity"
    change_column_default :characters, "vice", "Envy"
    change_column_default :characters, "clique_id", Clique.find_by_name("Solitary").id
    change_column_default :characters, "ideology_id", Ideology.find_by_name("Mortal").id
    change_column_default :characters, "user_id", User.find_by_name("Storyteller").id
  end

  def self.down
  end
end
