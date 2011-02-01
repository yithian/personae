class MoveTotemToClique < ActiveRecord::Migration
  def self.up
    add_column :cliques, :totem, :text
    remove_column :characters, :totem
  end

  def self.down
    remove_column :cliques, :totem
    add_column :characters, :totem, :text
  end
end
