class AddSpiritToSplats < ActiveRecord::Migration
  def change
    Splat.create(:name => "Spirit", :nature_name => "Nature", :clique_name => "Clique", :ideology_name => "Ideology", :morality_name => "Morality", :power_stat_name => "Rank", :fuel_name => "Essence")
    
    spirit_id = Splat.find_by_name("Spirit").id
    Nature.create(:name => "Spirit", :splat_id => spirit_id)
    Subnature.create(:name => "Spirit", :splat_id => spirit_id)
    Ideology.create(:name => "Spirit", :splat_id => spirit_id)
  end
end
