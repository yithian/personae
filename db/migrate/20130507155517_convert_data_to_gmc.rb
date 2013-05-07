class ConvertDataToGmc < ActiveRecord::Migration
  def up
    Splat.update_all("integrity_name = 'Integrity'", "integrity_name = 'Morality'")
  end

  def down
    Splat.update_all("integrity_name = 'Morality'", "integrity_name = 'Integrity'")
  end
end
