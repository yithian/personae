class AddMummySplat < ActiveRecord::Migration
  def self.up
    Splat.create(:name => "Mummy", :nature_name => "Decree", :clique_name => "Meret", :ideology_name => "Guild", :power_stat_name => "Sekhem", :fuel_name => "Fuel", :morality_name => "Memory", :subnature_name => "Judge")
    
    splat_id = Splat.find_by_name("Mummy").id
    Nature.create(:name => "Ab", :splat_id => splat_id)
    nature_id = Nature.find_by_name("Ab").id
    Subnature.create(:name => "Akhi", :nature_id => nature_id, :splat_id => splat_id)
    Subnature.create(:name => "Hepet-Khet", :nature_id => nature_id, :splat_id => splat_id)
    Subnature.create(:name => "Neb-Heru", :nature_id => nature_id, :splat_id => splat_id)
    Subnature.create(:name => "Neheb-Ka", :nature_id => nature_id, :splat_id => splat_id)
    Subnature.create(:name => "Qerrti", :nature_id => nature_id, :splat_id => splat_id)
    Subnature.create(:name => "Ruruti", :nature_id => nature_id, :splat_id => splat_id)
    Subnature.create(:name => "Ser-Tihu", :nature_id => nature_id, :splat_id => splat_id)
    Subnature.create(:name => "Tutuutef", :nature_id => nature_id, :splat_id => splat_id)
    Subnature.create(:name => "Usekh-Nemtet", :nature_id => nature_id, :splat_id => splat_id)
    
    Nature.create(:name => "Ba", :splat_id => splat_id)
    nature_id = Nature.find_by_name("Ba").id
    Subnature.create(:name => "An-Afkh", :nature_id => nature_id, :splat_id => splat_id)
    Subnature.create(:name => "Heraf-Het", :nature_id => nature_id, :splat_id => splat_id)
    Subnature.create(:name => "Neb-Abitu", :nature_id => nature_id, :splat_id => splat_id)
    Subnature.create(:name => "Nefer-Tem", :nature_id => nature_id, :splat_id => splat_id)
    Subnature.create(:name => "Neheb-Nefert", :nature_id => nature_id, :splat_id => splat_id)
    Subnature.create(:name => "Ser-Kheru", :nature_id => nature_id, :splat_id => splat_id)
    Subnature.create(:name => "Shet-Kheru", :nature_id => nature_id, :splat_id => splat_id)
    Subnature.create(:name => "Usekh-Nemtet", :nature_id => nature_id, :splat_id => splat_id)
    Subnature.create(:name => "Utu-Nesert", :nature_id => nature_id, :splat_id => splat_id)
    
    Nature.create(:name => "Ka", :splat_id => splat_id)
    nature_id = Nature.find_by_name("Ka").id
    Subnature.create(:name => "An-Hotep", :nature_id => nature_id, :splat_id => splat_id)
    Subnature.create(:name => "Fentu", :nature_id => nature_id, :splat_id => splat_id)
    Subnature.create(:name => "Hetch-Abhu", :nature_id => nature_id, :splat_id => splat_id)
    Subnature.create(:name => "Maa-Natuuf", :nature_id => nature_id, :splat_id => splat_id)
    Subnature.create(:name => "Neha-Hatu", :nature_id => nature_id, :splat_id => splat_id)
    Subnature.create(:name => "Set-Qesu", :nature_id => nature_id, :splat_id => splat_id)
    Subnature.create(:name => "Ta-Retinhu,", :nature_id => nature_id, :splat_id => splat_id)
    Subnature.create(:name => "Uamenti,", :nature_id => nature_id, :splat_id => splat_id)
    Subnature.create(:name => "Usekh-Nemtet", :nature_id => nature_id, :splat_id => splat_id)
    
    Nature.create(:name => "Ren", :splat_id => splat_id)
    nature_id = Nature.find_by_name("Ren").id
    Subnature.create(:name => "Bastu", :nature_id => nature_id, :splat_id => splat_id)
    Subnature.create(:name => "Kenemti", :nature_id => nature_id, :splat_id => splat_id)
    Subnature.create(:name => "Khem-Inhu", :nature_id => nature_id, :splat_id => splat_id)
    Subnature.create(:name => "Neb-Imkhu", :nature_id => nature_id, :splat_id => splat_id)
    Subnature.create(:name => "Sekhiru", :nature_id => nature_id, :splat_id => splat_id)
    Subnature.create(:name => "Tem-Sepu", :nature_id => nature_id, :splat_id => splat_id)
    Subnature.create(:name => "Uatch-Rekhet", :nature_id => nature_id, :splat_id => splat_id)
    Subnature.create(:name => "Unem-Besek", :nature_id => nature_id, :splat_id => splat_id)
    Subnature.create(:name => "Usekh-Nemtet", :nature_id => nature_id, :splat_id => splat_id)
    
    Nature.create(:name => "Sheut", :splat_id => splat_id)
    nature_id = Nature.find_by_name("Sheut").id
    Subnature.create(:name => "Am-Khaibit", :nature_id => nature_id, :splat_id => splat_id)
    Subnature.create(:name => "Artem-Khet", :nature_id => nature_id, :splat_id => splat_id)
    Subnature.create(:name => "Her-Uru", :nature_id => nature_id, :splat_id => splat_id)
    Subnature.create(:name => "Nebha", :nature_id => nature_id, :splat_id => splat_id)
    Subnature.create(:name => "Nekhenhu", :nature_id => nature_id, :splat_id => splat_id)
    Subnature.create(:name => "Tcheser-Tep", :nature_id => nature_id, :splat_id => splat_id)
    Subnature.create(:name => "Tenemhu", :nature_id => nature_id, :splat_id => splat_id)
    Subnature.create(:name => "Unem-Sef", :nature_id => nature_id, :splat_id => splat_id)
    Subnature.create(:name => "Usekh-Nemtet", :nature_id => nature_id, :splat_id => splat_id)
    
    Ideology.create(:name => "Maa-Kep", :splat_id => splat_id)
    Ideology.create(:name => "Mesen-Nebu", :splat_id => splat_id)
    Ideology.create(:name => "Sesha-Hesbu", :splat_id => splat_id)
    Ideology.create(:name => "Su-Menent", :splat_id => splat_id)
    Ideology.create(:name => "Tef-Aabhi", :splat_id => splat_id)
    
    add_column :characters, "ab", :integer, :default => 0, :null => false
    add_column :characters, "current_ab", :integer, :default => 0, :null => false
    add_column :characters, "ba", :integer, :default => 0, :null => false
    add_column :characters, "current_ba", :integer, :default => 0, :null => false
    add_column :characters, "ka", :integer, :default => 0, :null => false
    add_column :characters, "current_ka", :integer, :default => 0, :null => false
    add_column :characters, "ren", :integer, :default => 0, :null => false
    add_column :characters, "current_ren", :integer, :default => 0, :null => false
    add_column :characters, "sheut", :integer, :default => 0, :null => false
    add_column :characters, "current_sheut", :integer, :default => 0, :null => false
    add_column :characters, "affinities", :text
    add_column :characters, "utterances", :text
  end
  
  def self.down
    remove_column :characters, "ab"
    remove_column :characters, "current_ab"
    remove_column :characters, "ba"
    remove_column :characters, "current_ba"
    remove_column :characters, "ka"
    remove_column :characters, "current_ka"
    remove_column :characters, "ren"
    remove_column :characters, "current_ren"
    remove_column :characters, "sheut"
    remove_column :characters, "current_sheut"
    remove_column :characters, "affinities"
    remove_column :characters, "utterances"
    
    splat_id = Splat.find_by_name("Mummy").id
    Ideology.find_all_by_splat_id(splat_id).each { |i| i.delete }
    Nature.find_all_by_splat_id(splat_id).each { |i| i.delete }
    Subnature.find_all_by_splat_id(splat_id).each { |i| i.delete }
  end
end
