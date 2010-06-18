module IdeologiesHelper
  def known_ideology?(ideology)
    known_ideology = false
    ideology.characters.each do |member|
  		known_ideology = true if show_ideology?(member)
  	end
    
    session[:user_id] == User.find_by_name('Storyteller').id or known_ideology
  end
  
  def edit_ideology?(ideology)
    session[:user_id] == User.find_by_name('Storyteller').id
  end
end
