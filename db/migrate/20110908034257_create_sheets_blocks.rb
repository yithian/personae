class CreateSheetsBlocks < ActiveRecord::Migration
  def change
    create_table :sheets_blocks do |t|
      t.integer :sheet_id
      t.integer :block_id
      t.integer :order

      t.timestamps
    end
  end
end
