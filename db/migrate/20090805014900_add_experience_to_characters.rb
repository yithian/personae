class AddExperienceToCharacters < ActiveRecord::Migration
  def self.up
    add_column :characters, 'experience', :text
    add_column :characters, 'read_experience', :boolean, :default => false
  end

  def self.down
    remove_column :characters, 'read_experience'
    remove_column :characters, 'experience'
  end
end
