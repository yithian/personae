class CreateCabals < ActiveRecord::Migration
  def self.up
    create_table :cabals do |t|
      t.string :name
      t.string :territory
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :cabals
  end
end
