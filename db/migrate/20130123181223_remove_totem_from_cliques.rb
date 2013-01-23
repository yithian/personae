class RemoveTotemFromCliques < ActiveRecord::Migration
  def up
    remove_column :cliques, :totem
  end

  def down
    add_column :cliques, :totem, :text
  end
end
