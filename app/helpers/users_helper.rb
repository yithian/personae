module UsersHelper
  def edit_user?(user)
    session[:user_id] == User.find_by_name('Storyteller').id or session[:user_id] == user.id
  end
end
