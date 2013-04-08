# coding: utf-8
# Character helper module

module CharactersHelper
  # breaks strings of •s into groups of 5 for readability
  def dot_format(rating)
    ("•" * rating).gsub(/•{5}/, "••••• ").strip
  end

  def simple_markdown_format(field)
    field = make_rollable(field)
    field = clickable_backgrounds(field)
    field = simple_format(field)
    puts field if field.include? 'esource'
    field
  end

  def clickable_backgrounds(field)
    field.gsub(/\[\s*:([^:]*):\s*\*(\d+)\*\s*\]/) do
      name = $1
      value = $2
      output = "<div class='custom_stats'>"
      output << "<ul>"
      output << "<li class='dots_label'>#{name.capitalize}: </li>"
      output << "<li id='#{name.downcase}' class='dots_number'>#{dot_format value.to_i}</li>"
      output << "</ul>"
      #output << "<table class='custom_status'>"
      #output << "<tbody>"
      #output << "<tr>"
      #output << "<td class='dots_label'>#{name.capitalize}: </td>"
      #output << "<td id='#{name.downcase}' class='dots_number'>#{dot_format(value.to_i)}</td>"
      #output << "</tr>"
      #output << "<tbody>"
      #output << "</table>"
      output << "</div>"

      puts output
      output
    end
  end

  def make_rollable(field)
    field.gsub(/\[\s*:([^:]*): ([^*^\[]+(?:(?:(?:\+|-) [^*^\[]+)+)?)\s*(?:\s+\*([^*]+)\*)?\s*\]/) do
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
        stat = generalize_stat_name(stat)
        cl = []
        cl << 'no_count' if stat == ' + '
        if stat.starts_with?('-')
          cl << 'negative'
          stat = stat[1..-1]
        end
        output << "<li #{"class='#{cl.join ' '}'" unless cl.blank? }>#{stat}</li>"
      end
      output << "<br/>"
      output << "<li class='no_count'> (</li>" unless conditions.empty?
      conditions.each do |c|
        output << "<li class='roll_type'>#{c}</li>"
      end
      output << "<li class='no_count'>)</li>" unless conditions.empty?
      output << "</ul>"
      output << "</div>"
      output
    end
  end

  def generalize_stat_name(name)
    return 'Morality' if %w(harmony wisdom humanity synergy clarity memory).include?(name.downcase)
    return 'Power_Stat' if %w(gnosis wyrd psyche blood_potency primal_urge).include?(name.downcase)
    name
  end

end
