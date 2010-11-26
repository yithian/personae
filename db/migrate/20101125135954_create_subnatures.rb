class CreateSubnatures < ActiveRecord::Migration
  def self.up
    create_table :subnatures do |t|
      t.string :name
      t.integer :nature_id, :options => "fk_subnatures_nature REFERENCES nature(id)", :default => Nature.find_by_name("Mortal"), :null => false
      t.integer :splat_id, :options => "fk_subnatures_splat REFERENCES splat(id)", :default => Splat.find_by_name("Mortal"), :null => false

      t.timestamps
    end
    
    Subnature.create(:name => "Mortal", :nature_id => 0, :splat_id => Splat.find_by_name("Mortal").id)
    Subnature.create(:name => "Vampire", :nature_id => 0, :splat_id => Splat.find_by_name("Vampire").id)
    Subnature.create(:name => "Werewolf", :nature_id => 0, :splat_id => Splat.find_by_name("Werewolf").id)
    Subnature.create(:name => "Mage", :nature_id => 0, :splat_id => Splat.find_by_name("Mage").id)
    Subnature.create(:name => "Promethean", :nature_id => 0, :splat_id => Splat.find_by_name("Promethean").id)
    Subnature.create(:name => "Kithless", :nature_id => 0, :splat_id => Splat.find_by_name("Changeling").id)
    Subnature.create(:name => "Broadback", :nature_id => Nature.find_by_name("Beast").id, :splat_id => Splat.find_by_name("Changeling").id)
    Subnature.create(:name => "Hunterheart", :nature_id => Nature.find_by_name("Beast").id, :splat_id => Splat.find_by_name("Changeling").id)
    Subnature.create(:name => "Runnerswift", :nature_id => Nature.find_by_name("Beast").id, :splat_id => Splat.find_by_name("Changeling").id)
    Subnature.create(:name => "Skitterskulk", :nature_id => Nature.find_by_name("Beast").id, :splat_id => Splat.find_by_name("Changeling").id)
    Subnature.create(:name => "Steepscrambler", :nature_id => Nature.find_by_name("Beast").id, :splat_id => Splat.find_by_name("Changeling").id)
    Subnature.create(:name => "Swimmerskin", :nature_id => Nature.find_by_name("Beast").id, :splat_id => Splat.find_by_name("Changeling").id)
    Subnature.create(:name => "Venombite", :nature_id => Nature.find_by_name("Beast").id, :splat_id => Splat.find_by_name("Changeling").id)
    Subnature.create(:name => "Windwing", :nature_id => Nature.find_by_name("Beast").id, :splat_id => Splat.find_by_name("Changeling").id)
    Subnature.create(:name => "Antiquarian", :nature_id => Nature.find_by_name("Darkling").id, :splat_id => Splat.find_by_name("Changeling").id)
    Subnature.create(:name => "Gravewight", :nature_id => Nature.find_by_name("Darkling").id, :splat_id => Splat.find_by_name("Changeling").id)
    Subnature.create(:name => "Leechfinger", :nature_id => Nature.find_by_name("Darkling").id, :splat_id => Splat.find_by_name("Changeling").id)
    Subnature.create(:name => "Mirrorskin", :nature_id => Nature.find_by_name("Darkling").id, :splat_id => Splat.find_by_name("Changeling").id)
    Subnature.create(:name => "Tunnelgrub", :nature_id => Nature.find_by_name("Darkling").id, :splat_id => Splat.find_by_name("Changeling").id)
    Subnature.create(:name => "Airtouched", :nature_id => Nature.find_by_name("Elemental").id, :splat_id => Splat.find_by_name("Changeling").id)
    Subnature.create(:name => "Earthbones", :nature_id => Nature.find_by_name("Elemental").id, :splat_id => Splat.find_by_name("Changeling").id)
    Subnature.create(:name => "Fireheart", :nature_id => Nature.find_by_name("Elemental").id, :splat_id => Splat.find_by_name("Changeling").id)
    Subnature.create(:name => "Manikin", :nature_id => Nature.find_by_name("Elemental").id, :splat_id => Splat.find_by_name("Changeling").id)
    Subnature.create(:name => "Snowskin", :nature_id => Nature.find_by_name("Elemental").id, :splat_id => Splat.find_by_name("Changeling").id)
    Subnature.create(:name => "Waterborn", :nature_id => Nature.find_by_name("Elemental").id, :splat_id => Splat.find_by_name("Changeling").id)
    Subnature.create(:name => "Woodblood", :nature_id => Nature.find_by_name("Elemental").id, :splat_id => Splat.find_by_name("Changeling").id)
    Subnature.create(:name => "Bright One", :nature_id => Nature.find_by_name("Fairest").id, :splat_id => Splat.find_by_name("Changeling").id)
    Subnature.create(:name => "Dancer", :nature_id => Nature.find_by_name("Fairest").id, :splat_id => Splat.find_by_name("Changeling").id)
    Subnature.create(:name => "Draconic", :nature_id => Nature.find_by_name("Fairest").id, :splat_id => Splat.find_by_name("Changeling").id)
    Subnature.create(:name => "Flowering", :nature_id => Nature.find_by_name("Fairest").id, :splat_id => Splat.find_by_name("Changeling").id)
    Subnature.create(:name => "Muse", :nature_id => Nature.find_by_name("Fairest").id, :splat_id => Splat.find_by_name("Changeling").id)
    Subnature.create(:name => "Cyclopean", :nature_id => Nature.find_by_name("Ogre").id, :splat_id => Splat.find_by_name("Changeling").id)
    Subnature.create(:name => "Farwalker", :nature_id => Nature.find_by_name("Ogre").id, :splat_id => Splat.find_by_name("Changeling").id)
    Subnature.create(:name => "Gargantuan", :nature_id => Nature.find_by_name("Ogre").id, :splat_id => Splat.find_by_name("Changeling").id)
    Subnature.create(:name => "Gristlegrinder", :nature_id => Nature.find_by_name("Ogre").id, :splat_id => Splat.find_by_name("Changeling").id)
    Subnature.create(:name => "Stonebones", :nature_id => Nature.find_by_name("Ogre").id, :splat_id => Splat.find_by_name("Changeling").id)
    Subnature.create(:name => "Water-Dweller", :nature_id => Nature.find_by_name("Ogre").id, :splat_id => Splat.find_by_name("Changeling").id)
    Subnature.create(:name => "Artist", :nature_id => Nature.find_by_name("Wizened").id, :splat_id => Splat.find_by_name("Changeling").id)
    Subnature.create(:name => "Brewer", :nature_id => Nature.find_by_name("Wizened").id, :splat_id => Splat.find_by_name("Changeling").id)
    Subnature.create(:name => "Chatelaine", :nature_id => Nature.find_by_name("Wizened").id, :splat_id => Splat.find_by_name("Changeling").id)
    Subnature.create(:name => "Chirurgeon", :nature_id => Nature.find_by_name("Wizened").id, :splat_id => Splat.find_by_name("Changeling").id)
    Subnature.create(:name => "Oracle", :nature_id => Nature.find_by_name("Wizened").id, :splat_id => Splat.find_by_name("Changeling").id)
    Subnature.create(:name => "Soldier", :nature_id => Nature.find_by_name("Wizened").id, :splat_id => Splat.find_by_name("Changeling").id)
    Subnature.create(:name => "Woodwalker", :nature_id => Nature.find_by_name("Wizened").id, :splat_id => Splat.find_by_name("Changeling").id)
    Subnature.create(:name => "Hunter", :nature_id => 0, :splat_id => Splat.find_by_name("Hunter").id)
    Subnature.create(:name => "Geist", :nature_id => 0, :splat_id => Splat.find_by_name("Geist").id)
    
    add_column :characters, :subnature_id, :integer, :options => "fk_characters_subnature REFERENCES subnature(id)", :default => Subnature.find_by_name("Mortal").id, :null => false
    add_column :splats, :subnature_name, :string
    
    Splat.update_all("subnature_name = 'Mortal'", "name == 'Mortal'")
    Splat.update_all("subnature_name = 'Vampire'", "name == 'Vampire'")
    Splat.update_all("subnature_name = 'Werewolf'", "name == 'Werewolf'")
    Splat.update_all("subnature_name = 'Mage'", "name == 'Mage'")
    Splat.update_all("subnature_name = 'Promethean'", "name == 'Promethean'")
    Splat.update_all("subnature_name = 'Kith'", "name == 'Changeling'")
    Splat.update_all("subnature_name = 'Hunter'", "name == 'Hunter'")
    Splat.update_all("subnature_name = 'Geist'", "name == 'Geist'")
    
    Character.update_all("subnature_id = #{Subnature.find_by_name('Mortal').id}", "splat_id == #{Splat.find_by_name('Mortal').id}")
    Character.update_all("subnature_id = #{Subnature.find_by_name('Vampire').id}", "splat_id == #{Splat.find_by_name('Vampire').id}")
    Character.update_all("subnature_id = #{Subnature.find_by_name('Werewolf').id}", "splat_id == #{Splat.find_by_name('Werewolf').id}")
    Character.update_all("subnature_id = #{Subnature.find_by_name('Promethean').id}", "splat_id == #{Splat.find_by_name('Promethean').id}")
    Character.update_all("subnature_id = #{Subnature.find_by_name('Kithless').id}", "splat_id == #{Splat.find_by_name('Changeling').id}")
    Character.update_all("subnature_id = #{Subnature.find_by_name('Hunter').id}", "splat_id == #{Splat.find_by_name('Hunter').id}")
    Character.update_all("subnature_id = #{Subnature.find_by_name('Geist').id}", "splat_id == #{Splat.find_by_name('Geist').id}")
  end

  def self.down
    drop_table :subnatures
    remove_column :splats, :subnature_name
    remove_column :characters, :subnature_id
  end
end
