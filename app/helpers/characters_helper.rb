# coding: utf-8
# Character helper module

module CharactersHelper
  # breaks strings of •s into groups of 5 for readability
  def dot_format(rating)
    ("•" * rating).gsub(/•{5}/, "••••• ").strip
  end

  def simple_markdown_format(field)
    renderer = Rollable.new(self, hard_wrap: true, filter_html: true)
    marked_down = Redcarpet::Markdown.new(renderer).render(field).html_safe
    simple_format(marked_down)
  end

end
