# Chronicles contain characters and cliques -- presumably
# ideologies and natures will be static throughout all games
# -- as a way to have multiple games present in the same
# database.

class Chronicle < ActiveRecord::Base
  belongs_to :owner, class_name: "User"
  has_many :characters
  has_many :pcs, -> { where pc: 'true' }, class_name: "Character"
  has_many :npcs, -> { where pc: 'false' }, class_name: "Character"
  has_many :cliques
  has_many :selected_users, foreign_key: "selected_chronicle_id", class_name: "User"

  validates :name, :presence => true, :uniqueness => true

  before_destroy do |c|
    if Chronicle.count == 1
      raise "Can't delete the last chronicle"
    end

    nc = Chronicle.first.id

    c.characters.each do |character|
      character.chronicle_id = nc
      character.save
    end

    c.cliques.each do |clique|
      clique.chronicle_id = nc
      clique.save
    end

    c.selected_users.each do |user|
      user.selected_chronicle_id = nc
      user.save
    end
  end

  # Show the chronicle's name in the url
  def to_param
    "#{self.id}-#{self.name.gsub(/[ '"#%\{\}|\\^~\[\]`]/, '-').gsub(/[.&?\/:;=@]/, '')}"
  end

  # gets a paginated list of NPCs based on chronicle and user
  def find_npcs(user, page)
    if user and user.super_user?(self)
      npcs = Character.where("chronicle_id = #{self.id} and pc = false").page(page)
    elsif user
      npcs = Character.where("chronicle_id = #{self.id} and (read_name = true or owner_id = #{user.id}) and pc = false").page(page)
    else
      npcs = Character.where("chronicle_id = #{self.id} and read_name = true and pc = false").page(page)
    end

    return npcs
  end
end
