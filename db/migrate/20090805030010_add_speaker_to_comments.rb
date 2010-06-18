class AddSpeakerToComments < ActiveRecord::Migration
  def self.up
    add_column :comments, 'speaker', :string
  end

  def self.down
    remove_column :comments, 'speaker'
  end
end
