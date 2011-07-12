# Application-wide helper module

module ApplicationHelper
  # since users who aren't logged in won't have a current_user
  # we need to stick a value in their session data to keep track
  # of which chronicle they're viewing.
  def selected_chronicle_id(user, session)
    unless user.nil?
      user.selected_chronicle.id
    else
      session[:selected_chronicle_id] ||= Chronicle.first.id
    end
  end
end
