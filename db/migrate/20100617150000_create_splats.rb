class CreateSplats < ActiveRecord::Migration
  #  When adding new splats, add new rows to this table in a later migration
  def self.up
    create_table :splats do |t|
      t.string :name

      t.timestamps
    end
    Splat.create(:name => "Mortal")
    Splat.create(:name => "Mage")
  end

  def self.down
    drop_table :splats
  end
end
