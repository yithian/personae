# Creates a validator for Character.virtue . Valid virtues are 'Charity', 'Faith', 'Fortitude'
# 'Hope', 'Justice', 'Prudence' and 'Temperance'

class VirtueValidator < ActiveModel::EachValidator
  # Validates all records passed to it
  def validate_each(record, attribute, value)
    unless Character::VIRTUES.include?(value)
      record.errors[attribute] << "#{value} is an invalid virtue"
    end
  end
end
