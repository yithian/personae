class AddEmailToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :email_address, :string
  end

  def self.down
    remove_column :users, :email_address
  end
end
