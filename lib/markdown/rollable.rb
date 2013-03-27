class Rollable < Redcarpet::Render::HTML
  def initialize(character, args)
    @character = character
    super(args)
  end
  def normal_text(full_document)
    full_document.gsub(/\[:([^:]*): (\w+)(?: \+ (\w+))(?: \+ (\w+))\]/) do
      stat1 = @character.get_stat($2)
      stat2 = @character.get_stat($3)
      stat3 = @character.get_stat($4)

      "<b>#{$1}</b> is #{stat1 if stat1} + #{stat2 if stat2} + #{stat3 if stat3}"
    end
  end
end
