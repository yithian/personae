class AddPrometheanSplat < ActiveRecord::Migration
  def self.up
    Splat.create(:name => "Promethean", :nature_name => "Lineage", :clique_name => "Throng", :ideology_name => "Refinement", :morality_name => "Humanity", :power_stat_name => "Azoth", :fuel_name => "Pyros")

    Nature.create(:name => "Frankenstein", :splat_id => Splat.find_by_name("Promethean").id)
    Nature.create(:name => "Galatea", :splat_id => Splat.find_by_name("Promethean").id)
    Nature.create(:name => "Osirus", :splat_id => Splat.find_by_name("Promethean").id)
    Nature.create(:name => "Tammuz", :splat_id => Splat.find_by_name("Promethean").id)
    Nature.create(:name => "Ulgan", :splat_id => Splat.find_by_name("Promethean").id)

    Ideology.create(:name => "Aurum", :splat_id => Splat.find_by_name("Promethean").id)
    Ideology.create(:name => "Cuprum", :splat_id => Splat.find_by_name("Promethean").id)
    Ideology.create(:name => "Ferrum", :splat_id => Splat.find_by_name("Promethean").id)
    Ideology.create(:name => "Mercurius", :splat_id => Splat.find_by_name("Promethean").id)
    Ideology.create(:name => "Stannum", :splat_id => Splat.find_by_name("Promethean").id)
    Ideology.create(:name => "Centimani", :splat_id => Splat.find_by_name("Promethean").id)

    add_column :characters, "transmutations", :text
  end

  def self.down
    remove_column :characters, "transmutations"

    Ideology.find_by_name("Centimani").delete
    Ideology.find_by_name("Stannum").delete
    Ideology.find_by_name("Mercurius").delete
    Ideology.find_by_name("Ferrum").delete
    Ideology.find_by_name("Cuprum").delete
    Ideology.find_by_name("Aurum").delete

    Nature.find_by_name("Ulgan").delete
    Nature.find_by_name("Tammuz").delete
    Nature.find_by_name("Osirus").delete
    Nature.find_by_name("Galatea").delete
    Nature.find_by_name("Frankenstein").delete

    Splat.find_by_name("Promethean").delete
  end
end
