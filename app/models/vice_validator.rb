# Creates a validator for Character.vice . Valid vices are 'Envy', 'Gluttony', 'Greed', 'Lust'
# 'Sloth', 'Pride', 'Wrath'

class ViceValidator < ActiveModel::EachValidator
  # Validates all records passed to it
  def validate_each(record, attribute, value)
    vices = value.split(" ")
    
    record.errors[attribute] << "Too many vices selected" unless vices.length < 3
    
    vices.each do |vice|
      unless Character::VICES.include? vice
        record.errors[attribute] << "#{vice} is an invalid vice"
      end
    end
  end
end
