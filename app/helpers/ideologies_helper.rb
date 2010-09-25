module IdeologiesHelper
  def edit_ideology?(ideology)
    session[:user_id] == User.find_by_name('Storyteller').id
  end
end
