# Application-wide helper module

module ApplicationHelper
  # creates a li with class="selected" if the condition is true
  def li_selected_if(condition, attributes = {}, &block)
    attributes["class"] = "selected" if condition
    
    content_tag('li', attributes, &block)
  end
end
