class CleanPermissionsOnCharacters < ActiveRecord::Migration
  def change
    rename_column :characters, :read_attributes, :read_crunch
    remove_column :characters, :read_skills, :read_advantages, :read_merits, :read_powers, :read_equipment
  end
end
