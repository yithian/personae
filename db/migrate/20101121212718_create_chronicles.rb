class CreateChronicles < ActiveRecord::Migration
  def self.up
    create_table :chronicles do |t|
      t.string :name
      t.text :description
      
      t.timestamps
    end
    Chronicle.create(:name => "Generic")
    
    add_column :characters, :chronicle_id, :integer, :options => "fk_characters_chronicle REFERENCES chronicle(id)", :default => Chronicle.find_by_name("Generic")
    add_column :cliques, :chronicle_id, :integer, :options => "fk_chliques_chronicle REFERENCES chronicle(id)", :default => Chronicle.find_by_name("Generic")
    add_column :users, :chronicle_id, :integer, :options => "fk_chliques_chronicle REFERENCES chronicle(id)", :default => Chronicle.find_by_name("Generic"), :null => false
    
    Character.update_all("chronicle_id = 1", "chronicle_id IS NULL")
    Clique.update_all("chronicle_id = 1", "chronicle_id IS NULL")
    User.update_all("chronicle_id = 1", "chronicle_id IS NULL")
  end

  def self.down
    remove_column :cliques, :chronicle_id
    remove_column :characters, :chronicle_id

    drop_table :chronicles
  end
end