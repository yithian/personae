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

      output = "<span class='rollable #{$1}'>#{$1}: #{stat1 if stat1} + #{stat2 if stat2} + #{stat3 if stat3}</span>"
      output << "<ul class='rollable #{$1}' style='display:none'>"
      output << "<li>#{$2}</li>" if $2
      output << "<li>#{$3}</li>" if $3
      output << "<li>#{$4}</li>" if $4
      output << "</ul>"
      output
    end
  end
end
