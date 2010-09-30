class AddBanisherIdeology < ActiveRecord::Migration
  def self.up
    Ideology.create(:name => "Banishers", :splat_id => Splat.find_by_name("Mage").id)
  end

  def self.down
    Ideology.find_by_name("Banishers").delete
  end
end
