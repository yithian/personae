class BlocksBlocks < ActiveRecord::Base
  belongs_to :inner_block, :foreign_key => :inner_block_id, :class_name => "Block"
  belongs_to :outer_block, :foreign_key => :outer_block_id, :class_name => "Block"
end
