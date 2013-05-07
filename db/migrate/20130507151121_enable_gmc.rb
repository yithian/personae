class EnableGmc < ActiveRecord::Migration
  def change
    add_column :characters, :aspirations, :text
    add_column :characters, :breaking_points, :text
    rename_column :characters, :morality, :integrity
    rename_column :characters, :derangements, :conditions
    rename_column :characters, :experience, :experiences
    rename_column :characters, :read_experience, :read_experiences
    rename_column :splats, :morality_name, :integrity_name
  end
end
