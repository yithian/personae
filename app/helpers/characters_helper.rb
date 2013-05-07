# coding: utf-8
# Character helper module

module CharactersHelper
  # breaks strings of •s into groups of 5 for readability
  def dot_format(rating)
    ("•" * rating).gsub(/•{5}/, "••••• ").strip
  end

  def simple_markdown_format(field)
    field = clickable_specialties(field)
    field = make_rollable(field)
    field = clickable_stats(field)
    simple_format(field)
  end

  def clickable_stats(field)
    field.gsub(/\[\s*:([^:]*): \*(\d+)\*\s*(\([^:]*\))?\s*\][\r\n]{0,2}/) do
      name = $1
      value = $2
      conditions = $3
      output = "<div class='custom_stats'>"
      output << "<ul>"
      output << "<li class='dots_label'>#{name.titleize}: </li>"
      output << "<li id='#{name.downcase}' class='dots_number'>#{dot_format value.to_i}</li>"
      output << "<li class='dots_description'> #{conditions}</li>" if conditions
      output << "</ul>"
      output << "</div>"

      output
    end
  end

  def clickable_specialties(field)
    field.gsub(/\[\s*:([^:]*):\s*\(([^)]*)\)\s*\][\r\n]{0,2}/) do
      skill = $1
      description = $2
      spaceless_desc = description.gsub(" ", "_")
      output = "<div class='custom_stats'>"
      output << "<ul>"
      output << "<li class='dots_label'>#{skill.titleize} (#{description})</li>"
      output << "<li id='#{skill.downcase}_#{spaceless_desc.downcase}' class='specialty_value dots_number'>#{dot_format 1}</li>"
      output << "</ul>"
      output << "</div>"

      output
    end
  end

  def make_rollable(field)
    field.gsub(/\[\s*:([^:]*): ([^*^\[]+(?:(?:(?:\+|-) [^*^\[]+)+)?)\s*(?:\s+\*([^*]+)\*)?\s*\]/) do
      name = $1
      stats = $2
      conditions = $3 || ""

      # Processing the list of stats
      # Convert all the -s into '+ -' so that we don't lose track of it
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
      # Pulling the first stat off since and then we have pairs of
      # + and stat as the elements.
      # There should be no li class for this, since it won't be
      # subtracted or not counting
      output << "<li>#{stat_list.shift.capitalize}</li>"
      # Iterating over each consecutive pair and then exiting the
      # first isn't a + or -
      # This lets us know if we need to make the stat negative
      stat_list.each_cons(2) do |first, second|
        # skip if we didn't start with a + sign
        # The whole loop is based on that assumption
        next unless first == ' + '
        cl = []
        second = generalize_stat_name(second)
        if second.starts_with?('-')
          cl << 'negative'
          second = second[1..-1]
          first = ' - '
        end
        output << "<li class='no_count'>#{first}</li>"
        output << "<li #{"class='#{cl.join ' '}'" unless cl.blank? }>#{second}</li>"
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
    return 'Integrity' if %w(harmony wisdom humanity synergy clarity memory).include?(name.downcase)
    return 'Power_Stat' if %w(gnosis wyrd psyche blood_potency primal_urge azoth sekhem rank).include?(name.downcase)
    name.capitalize
  end

end
