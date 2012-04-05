class StandardizePossessedAttributes < ActiveRecord::Migration
  def up
    remove_column :characters, :infernal_will
    
    add_column :characters, :current_infernal_will, :string
  end

  def down
    add_column :characters, :infernal_will, :integer
    
    remove_column :characters, :current_infernal_will
  end
end
