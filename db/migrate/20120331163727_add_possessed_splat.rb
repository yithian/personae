class AddPossessedSplat < ActiveRecord::Migration
  def change
    add_column :characters, :possessed, :boolean, :default => false
    add_column :characters, :infernal_will, :integer, :default => 0
    add_column :characters, :envy, :integer, :default => 0
    add_column :characters, :gluttony, :integer, :default => 0
    add_column :characters, :greed, :integer, :default => 0
    add_column :characters, :lust, :integer, :default => 0
    add_column :characters, :pride, :integer, :default => 0
    add_column :characters, :sloth, :integer, :default => 0
    add_column :characters, :wrath, :integer, :default => 0
    add_column :characters, :vestments, :text
    add_column :characters, :primary_vice, :string
  end
end
