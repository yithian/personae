# coding: utf-8
# Character helper module

module CharactersHelper
  # breaks strings of •s into groups of 5 for readability
  def dot_format(rating)
    ("•" * rating).gsub(/•{5}/, "••••• ").strip
  end

  def simple_markdown_format(field)
    marked_down = field.gsub(/\[\s*:([^:]*): (\w+(?: \+ \w+)+)\s*(?:\*([^*]+)\*)?\]/) do
      name = $1
      stats = $2
      conditions = $3 || ""
      stat_list = stats.split(' + ')
      stat_list = stat_list.map{|x| [x, ' + ']}.flatten
      stat_list.pop
      puts stat_list.inspect

      conditions = conditions.split(',').map(&:strip)

      output = "<div class='rollable'>"
      output << "<span class='rollable'>#{name.capitalize}</span>"
      output << "<ul class='roll_stats'>"
      stat_list.each do |stat|
        # I'm a hack, put me in a helper
        stat = 'Morality' if %w(harmony wisdom humanity synergy clarity memory).include?(stat.downcase)
        # TODO: Handle power stat conversion at some point
        #stat = "Power_Stat" if %w(gnosis wyrd psyche blood_potency
        output << "<li class='no_count'>#{stat}</li>" if stat == ' + '
        output << "<li>#{stat}</li>" unless stat == ' + '
        puts stat
      end
      conditions.each do |c|
        output << "<li class='roll_type'>#{c}</li>"
      end
      output << "</ul>"
      output << "</div>"
      output
    end
    simple_format(marked_down)
  end

end
