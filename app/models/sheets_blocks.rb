class SheetsBlocks < ActiveRecord::Base
  belongs_to :block
  belongs_to :sheet
end
