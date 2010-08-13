class AddHunterSplat < ActiveRecord::Migration
  def self.up
    Splat.create(:name => "Hunter", :nature_name => "Profession", :clique_name => "Cell", :ideology_name => "Organization", :morality_name => "Morality", :power_stat_name => "Power Stat", :fuel_name => "fuel")
    
    Nature.create(:name => "Academic", :splat_id => Splat.find_by_name("Hunter").id)
    Nature.create(:name => "Artist", :splat_id => Splat.find_by_name("Hunter").id)
    Nature.create(:name => "Athlete", :splat_id => Splat.find_by_name("Hunter").id)
    Nature.create(:name => "Cop", :splat_id => Splat.find_by_name("Hunter").id)
    Nature.create(:name => "Criminal", :splat_id => Splat.find_by_name("Hunter").id)
    Nature.create(:name => "Detective", :splat_id => Splat.find_by_name("Hunter").id)
    Nature.create(:name => "Doctor", :splat_id => Splat.find_by_name("Hunter").id)
    Nature.create(:name => "Engineer", :splat_id => Splat.find_by_name("Hunter").id)
    Nature.create(:name => "Hacker", :splat_id => Splat.find_by_name("Hunter").id)
    Nature.create(:name => "Hit Man", :splat_id => Splat.find_by_name("Hunter").id)
    Nature.create(:name => "Journalist", :splat_id => Splat.find_by_name("Hunter").id)
    Nature.create(:name => "Laborer", :splat_id => Splat.find_by_name("Hunter").id)
    Nature.create(:name => "Occultist", :splat_id => Splat.find_by_name("Hunter").id)
    Nature.create(:name => "Professional", :splat_id => Splat.find_by_name("Hunter").id)
    Nature.create(:name => "Religious Leader", :splat_id => Splat.find_by_name("Hunter").id)
    Nature.create(:name => "Scientist", :splat_id => Splat.find_by_name("Hunter").id)
    Nature.create(:name => "Socialite", :splat_id => Splat.find_by_name("Hunter").id)
    Nature.create(:name => "Soldier", :splat_id => Splat.find_by_name("Hunter").id)
    Nature.create(:name => "Technician", :splat_id => Splat.find_by_name("Hunter").id)
    Nature.create(:name => "Vagrant", :splat_id => Splat.find_by_name("Hunter").id)
    
    Ideology.create(:name => "None", :splat_id => Splat.find_by_name("Hunter").id)
    Ideology.create(:name => "Ashwood Abbey", :splat_id => Splat.find_by_name("Hunter").id)
    Ideology.create(:name => "The Long Night", :splat_id => Splat.find_by_name("Hunter").id)
    Ideology.create(:name => "The Loyalists of Thule", :splat_id => Splat.find_by_name("Hunter").id)
    Ideology.create(:name => "Network Zero", :splat_id => Splat.find_by_name("Hunter").id)
    Ideology.create(:name => "Null Mysteriis", :splat_id => Splat.find_by_name("Hunter").id)
    Ideology.create(:name => "The Union", :splat_id => Splat.find_by_name("Hunter").id)
    Ideology.create(:name => "Aegis Kai Doru", :splat_id => Splat.find_by_name("Hunter").id)
    Ideology.create(:name => "Ascending Ones", :splat_id => Splat.find_by_name("Hunter").id)
    Ideology.create(:name => "The Cheiron Group", :splat_id => Splat.find_by_name("Hunter").id)
    Ideology.create(:name => "The Lucifuge", :splat_id => Splat.find_by_name("Hunter").id)
    Ideology.create(:name => "Malleus Maleficarum", :splat_id => Splat.find_by_name("Hunter").id)
    Ideology.create(:name => "Task Force Valkyrie", :splat_id => Splat.find_by_name("Hunter").id)
  end

  def self.down
    Ideology.find_by_name("Task Force Valkyrie").delete
    Ideology.find_by_name("Malleus Maleficarum").delete
    Ideology.find_by_name("The Lucifuge").delete
    Ideology.find_by_name("The Cheiron Group").delete
    Ideology.find_by_name("Ascending Ones").delete
    Ideology.find_by_name("Aegis Kai Doru").delete
    Ideology.find_by_name("The Union").delete
    Ideology.find_by_name("Null Mysteriis").delete
    Ideology.find_by_name("Network Zero").delete
    Ideology.find_by_name("The Loyalists of Thule").delete
    Ideology.find_by_name("The Long Night").delete
    Ideology.find_by_name("Ashwood Abbey").delete
    Ideology.find_by_name("None").delete
    
    Nature.find_by_name("Vagrant").delete
    Nature.find_by_name("Technician").delete
    Nature.find_by_name("Soldier").delete
    Nature.find_by_name("Socialite").delete
    Nature.find_by_name("Scientist").delete
    Nature.find_by_name("Religious Leader").delete
    Nature.find_by_name("Professional").delete
    Nature.find_by_name("Occultist").delete
    Nature.find_by_name("Laborer").delete
    Nature.find_by_name("Journalist").delete
    Nature.find_by_name("Hit Man").delete
    Nature.find_by_name("Hacker").delete
    Nature.find_by_name("Engineer").delete
    Nature.find_by_name("Doctor").delete
    Nature.find_by_name("Detective").delete
    Nature.find_by_name("Criminal").delete
    Nature.find_by_name("Cop").delete
    Nature.find_by_name("Athlete").delete
    Nature.find_by_name("Artist").delete
    Nature.find_by_name("Academic").delete
    
    Splat.find_by_name("Hunter").delete
  end
end
