module CabalsHelper
  def known_cabal?(cabal)
    known_cabal = false
    cabal.characters.each do |member|
  		known_cabal = true if show_cabal?(member)
  	end
  	
  	session[:user_id] == User.find_by_name('Storyteller').id or cabal.user_id == session[:user_id] or cabal.write or known_cabal
  end
  
  def edit_cabal?(cabal)
    session[:user_id] == User.find_by_name('Storyteller').id or cabal.user_id == session[:user_id] or cabal.write
  end
end
