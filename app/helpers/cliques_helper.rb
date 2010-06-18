module CliquesHelper
  def known_clique?(clique)
    known_clique = false
    clique.characters.each do |member|
  		known_clique = true if show_clique?(member)
  	end
  	
  	session[:user_id] == User.find_by_name('Storyteller').id or clique.user_id == session[:user_id] or clique.write or known_clique
  end
  
  def edit_clique?(clique)
    session[:user_id] == User.find_by_name('Storyteller').id or clique.user_id == session[:user_id] or clique.write
  end
end
