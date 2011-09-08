class CreateSheets < ActiveRecord::Migration
  def change
    create_table :sheets do |t|
      t.user_id :int
      t.chronicle_id :int
      t.description :string
      t.name :string

      t.timestamps
    end
  end
end
