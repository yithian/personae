class AddOrders < ActiveRecord::Migration
  def self.up
    Order.delete_all
    Order.create(:name => "Adamantine Arrow")
    Order.create(:name => "Free Council")
    Order.create(:name => "Guardians of the Veil")
    Order.create(:name => "Mysterium")
    Order.create(:name => "Silver Ladder")
    Order.create(:name => "Apostate")
  end

  def self.down
    Order.delete_all
  end
end
