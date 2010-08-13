class AddChangelingSplat < ActiveRecord::Migration
  def self.up
    Splat.create(:name => "Changeling", :nature_name => "Seeming", :clique_name => "Motley", :ideology_name => "Court", :morality_name => "Clarity", :power_stat_name => "Wyrd", :fuel_name => "Glamour")
    
    Nature.create(:name => "Beast", :splat_id => Splat.find_by_name("Changeling").id)
    Nature.create(:name => "Darkling", :splat_id => Splat.find_by_name("Changeling").id)
    Nature.create(:name => "Elemental", :splat_id => Splat.find_by_name("Changeling").id)
    Nature.create(:name => "Fairest", :splat_id => Splat.find_by_name("Changeling").id)
    Nature.create(:name => "Ogre", :splat_id => Splat.find_by_name("Changeling").id)
    Nature.create(:name => "Wizened", :splat_id => Splat.find_by_name("Changeling").id)

    Ideology.create(:name => "Spring", :splat_id => Splat.find_by_name("Changeling").id)
    Ideology.create(:name => "Summer", :splat_id => Splat.find_by_name("Changeling").id)
    Ideology.create(:name => "Autumn", :splat_id => Splat.find_by_name("Changeling").id)
    Ideology.create(:name => "Fall", :splat_id => Splat.find_by_name("Changeling").id)
    Ideology.create(:name => "Courtless", :splat_id => Splat.find_by_name("Changeling").id)

    add_column :characters, "dream", :integer, :default => 0, :null => false
    add_column :characters, "hearth", :integer, :default => 0, :null => false
    add_column :characters, "mirror", :integer, :default => 0, :null => false
    add_column :characters, "smoke", :integer, :default => 0, :null => false
    add_column :characters, "artifice", :integer, :default => 0, :null => false
    add_column :characters, "darkness", :integer, :default => 0, :null => false
    add_column :characters, "elements", :integer, :default => 0, :null => false
    add_column :characters, "fang_and_tooth", :integer, :default => 0, :null => false
    add_column :characters, "stone", :integer, :default => 0, :null => false
    add_column :characters, "vainglory", :integer, :default => 0, :null => false
    add_column :characters, "fleeting_spring", :integer, :default => 0, :null => false
    add_column :characters, "eternal_spring", :integer, :default => 0, :null => false
    add_column :characters, "fleeting_summer", :integer, :default => 0, :null => false
    add_column :characters, "eternal_summer", :integer, :default => 0, :null => false
    add_column :characters, "fleeting_autumn", :integer, :default => 0, :null => false
    add_column :characters, "eternal_autumn", :integer, :default => 0, :null => false
    add_column :characters, "fleeting_winter", :integer, :default => 0, :null => false
    add_column :characters, "eternal_winter", :integer, :default => 0, :null => false
    add_column :characters, "goblin_contracts", :text
    add_column :characters, "pledges", :text
  end

  def self.down
    remove_column :characters, "pledges"
    remove_column :characters, "goblin_contracts"
    remove_column :characters, "eternal_winter"
    remove_column :characters, "fleeting_winter"
    remove_column :characters, "eternal_autumn"
    remove_column :characters, "fleeting_autumn"
    remove_column :characters, "eternal_summer"
    remove_column :characters, "fleeting_summer"
    remove_column :characters, "eternal_spring"
    remove_column :characters, "fleeting_spring"
    remove_column :characters, "vainglory"
    remove_column :characters, "stone"
    remove_column :characters, "fang_and_tooth"
    remove_column :characters, "elements"
    remove_column :characters, "darkness"
    remove_column :characters, "artifice"
    remove_column :characters, "smoke"
    remove_column :characters, "mirror"
    remove_column :characters, "hearth"
    remove_column :characters, "dream"

    Ideology.find_by_name("Courtless").destroy
    Ideology.find_by_name("Fall").destroy
    Ideology.find_by_name("Autumn").destroy
    Ideology.find_by_name("Summer").destroy
    Ideology.find_by_name("Spring").destroy

    Nature.find_by_name("Wizened").destroy
    Nature.find_by_name("Ogre").destroy
    Nature.find_by_name("Fairest").destroy
    Nature.find_by_name("Elemental").destroy
    Nature.find_by_name("Darkling").destroy
    Nature.find_by_name("Beast").destroy
  end
end
