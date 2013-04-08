# coding: utf-8
# Character helper module

module CharactersHelper
  # breaks strings of •s into groups of 5 for readability
  def dot_format(rating)
    ("•" * rating).gsub(/•{5}/, "••••• ").strip
  end

  def simple_markdown_format(field)
    #marked_down = field.gsub(/\[\s*:([^:]*): ([^*]+(?: (?:\+|-) [^*]+)+)\s*(?:\s+\*([^*]+)\*)?\s*\]/) do
    marked_down = field.gsub(/\[\s*:([^:]*): ([^*^\[]+(?:(?:(?:\+|-) [^*^\[]+)+)?)\s*(?:\s+\*([^*]+)\*)?\s*\]/) do
      name = $1
      stats = $2
      conditions = $3 || ""

      # Processing the list of stats
      # We add a ' + ' element in between the stats so it will
      # look nice when we hover over the list
      stats = stats.gsub(' - ', ' + -')
      stat_list = stats.split(' + ')
      stat_list = stat_list.map{|x| [x.strip.gsub(" ", "_").downcase, ' + ']}.flatten
      stat_list.pop

      # Processing the condtions list
      # We add a ' , ' so it will be a list of conditions
      conditions = conditions.split(',').map(&:strip)
      conditions = conditions.map{|x| [x, ' , ']}.flatten
      conditions.pop

      output = "<div class='rollable'>"
      output << "<span class='rollable'>#{name.capitalize}</span>"
      output << "<ul class='roll_stats'>"
      output << "<br/>"
      stat_list.each do |stat|
        # I'm a hack, put me in a helper
        stat = 'Morality' if %w(harmony wisdom humanity synergy clarity memory).include?(stat.downcase)
        # TODO: Handle power stat conversion at some point
        stat = "Power_Stat" if %w(gnosis wyrd psyche blood_potency primal_urge).include?(stat.downcase)
        cl = []
        cl << 'no_count' if stat == ' + '
        if stat.starts_with?('-')
          cl << 'negative'
          stat = stat[1..-1]
        end
        output << "<li #{"class='#{cl.join ' '}'" unless cl.blank? }>#{stat}</li>"
        puts stat
      end
      output << "<br/>"
      output << "<li class='no_count'> (</li>" unless conditions.empty?
      conditions.each do |c|
        output << "<li class='roll_type'>#{c}</li>"
      end
      output << "<li class='no_count'>)</li>" unless conditions.empty?
      output << "</ul>"
      output << "</div>"
      puts output
      output
    end
    simple_format(marked_down)
  end

end
