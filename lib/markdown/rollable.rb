class Rollable < Redcarpet::Render::HTML
  def initialize(character, args)
    @character = character
    super(args)
  end
  def normal_text(full_document)
    full_document.gsub(/\[\s*:([^:]*): (\w+(?: \+ \w+)+)\s*\]/) do
      name = $1
      stats = $2
      stat_list = stats.split(' + ')
      stat_list = stat_list.map{|x| [x, ' + ']}.flatten
      stat_list.pop
      puts stat_list

      output = "<div class='rollable'>"
      output << "<span class='rollable'>#{name.capitalize}</span>"
      output << "<ul class='roll_stats'>"
      stat_list.each do |stat|
        # I'm a hack, put me in a helper
        stat = 'Morality' if %w(harmony wisdom humanity synergy clarity memory).include?(stat.downcase)
        output << "<li#{'class="no_count"' if stat == ' + '}>#{stat}</li>"
      end
      output << "</ul>"
      output << "</div>"
      output
    end
  end
end
