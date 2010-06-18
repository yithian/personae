class AddReadCabalAndReadOrderToCharacters < ActiveRecord::Migration
  def self.up
    add_column :characters, 'read_cabal', :boolean, :default => false
    add_column :characters, 'read_order', :boolean, :default => false
    
    remove_column :cabals, 'read'
    remove_column :orders, 'read'
  end

  def self.down
    add_column :orders, 'read', :boolean
    add_column :cabals, 'read', :boolean
    
    remove_column :characters, 'read_order'
    remove_column :characters, 'read_cabal'
  end
end
