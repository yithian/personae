class CreateNatures < ActiveRecord::Migration
  def self.up
    add_table 'natures' do |t|
      t.string 'name'
      t.integer 'splat_id', :null => false, :options => "CONSTRAINT fk_nature_splats REFERENCES splat(id)"
    end
    Nature.create(:name => 'Acanthus', :splat_id => Splat.find_by_name('Mage'))
    Nature.create(:name => 'Mastigos', :splat_id => Splat.find_by_name('Mage'))
    Nature.create(:name => 'Moros', :splat_id => Splat.find_by_name('Mage'))
    Nature.create(:name => 'Obrimos', :splat_id => Splat.find_by_name('Mage'))
    Nature.create(:name => 'Tyrsus', :splat_id => Splat.find_by_name('Mage'))
    Nature.create(:name => 'Rahu', :splat_id => Splat.find_by_name('Werewolf'))
    Nature.create(:name => 'Cahalith', :splat_id => Splat.find_by_name('Werewolf'))
    Nature.create(:name => 'Elodoth', :splat_id => Splat.find_by_name('Werewolf'))
    Nature.create(:name => 'Ithaeur', :splat_id => Splat.find_by_name('Werewolf'))
    Nature.create(:name => 'Irraka', :splat_id => Splat.find_by_name('Werewolf'))
    
    add_column :characters, 'nature_id', :integer, :null => false, :options => "CONSTRAINT fk_character_natures REFERENCES nature(id)"
    ###
    #  convert paths to nature_ids before removing the column
    #  This table still needs a model generated (./generate model -g natures)
    ###
    remove_column :characters, 'path'
  end

  def self.down
  end
end
