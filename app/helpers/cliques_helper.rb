module CliquesHelper
  def edit_clique?(clique)
    session[:user_id] == User.find_by_name('Storyteller').id or clique.user_id == session[:user_id] or clique.write
  end
end
