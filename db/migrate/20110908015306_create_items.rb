class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.name :string
      t.type :string
      t.entry_id :int

      t.timestamps
    end
  end
end
