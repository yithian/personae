module OrdersHelper
  def known_order?(order)
    known_order = false
    order.characters.each do |member|
  		known_order = true if show_order?(member)
  	end
    
    session[:user_id] == User.find_by_name('Storyteller').id or known_order
  end
  
  def edit_order?(order)
    session[:user_id] == User.find_by_name('Storyteller').id
  end
end
