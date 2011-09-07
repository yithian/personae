# Creates a validator which ensures only one Character or Clique may have the same
# name within a Chronicle

class UniqueInChronicleValidator < ActiveModel::EachValidator
  # Validates all records passed to it
  def validate_each(record, attribute, value)
    return if record.chronicle_id == 0
    
    if record.class.name == "Character"
      record.chronicle.characters.each do |character|
        record.errors[attribute] << "Another character with this name already exists in this chronicle." if character.name == value and not character.id == record.id
      end
    elsif record.class.name == "Clique"
      record.chronicle.cliques.each do |clique|
        record.errors[attribute] << "Another clique with this name already exists in this chronicle." if clique.name == value and not clique.id == record.id
      end
    end
  end
end
