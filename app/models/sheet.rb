class Sheet < ActiveRecord::Base
  has_many :sheets_blocks
  has_many :blocks, :through => :sheets_blocks
end
