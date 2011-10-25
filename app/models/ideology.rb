# Ideologies are loose social organizations that are typically world-spanning. Obviously,
# their members cross cliques and may or may not even know about one another but will
# typically have similar goals and/or motivations.

class Ideology < ActiveRecord::Base
  has_many :characters
  belongs_to :splat

  validates :name, :presence => true, :uniqueness => true
  validates :splat_id, :presence => true

  # Show the ideology's name in the url
  def to_param
    "#{self.id}-#{self.name.gsub(' ', '-')}"
  end
end
