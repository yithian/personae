class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.references :user, :options => "CONSTRAINT fk_comment_users REFERENCES user(id)"
      t.references :character, :options => "CONSTRAINT fk_comment_characters REFERENCES character(id)"
      t.text :body

      t.timestamps
    end
  end

  def self.down
    drop_table :comments
  end
end
