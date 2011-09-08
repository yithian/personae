class CreateBlocksBlocks < ActiveRecord::Migration
  def change
    create_table :blocks_blocks do |t|
      t.inner_block_id :int
      t.outer_block_id :int
      t.order :int

      t.timestamps
    end
  end
end
