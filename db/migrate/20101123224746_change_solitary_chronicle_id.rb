class ChangeSolitaryChronicleId < ActiveRecord::Migration
  def self.up
    Clique.update_all("chronicle_id = 0", "name = 'Solitary'")
  end

  def self.down
  end
end
