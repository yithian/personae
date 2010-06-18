module CommentHelper
  def edit_comment?(comment)
    session[:user_id] == User.find_by_name('Storyteller').id or comment.user_id == session[:user_id]
  end
end
