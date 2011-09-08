class Block < ActiveRecord::Base
  has_many :items
  has_many :sheets_blocks
  has_many :sheets, :through => :sheets_blocks
  has_many :inner_blocks, :through => :blocks_blocks
  has_many :outer_blocks, :through => :blocks_blocks

  # Validations
  
  validate :content_orientation, :inclusion => { :in => %w(vertical horizontal), :message => "%{value} is not horizontal or vertical" }

end
