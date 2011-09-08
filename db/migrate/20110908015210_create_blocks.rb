class CreateBlocks < ActiveRecord::Migration
  def change
    create_table :blocks do |t|
      t.string :name
      t.string :content_orientation

      t.timestamps
    end
  end
end
