# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  before_filter :authorize, :except => [:login, :logout]
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  protected
  def authorize
    unless User.find_by_id(session[:user_id])
      session[:original_uri] = request.fullpath
      flash[:notice] = "Please log in"
      redirect_to :controller => :admin, :action => :login
    end
  end

  def own_character?(char)
    session[:user_id] == User.find_by_name('Storyteller').id or char.user_id == session[:user_id]
  end
  helper_method :own_character?

  def show_character?(char)
    session[:user_id] == User.find_by_name('Storyteller').id or char.user_id == session[:user_id] or char.read_name
  end
  helper_method :show_character?
  
  def show_nature?(char)
    session[:user_id] == User.find_by_name('Storyteller').id or char.user_id == session[:user_id] or char.read_nature
  end
  helper_method :show_nature?
  
  def show_clique?(char)
    session[:user_id] == User.find_by_name('Storyteller').id or char.user_id == session[:user_id] or char.read_clique
  end
  helper_method :show_clique?
  
  def show_ideology?(char)
    session[:user_id] == User.find_by_name('Storyteller').id or char.user_id == session[:user_id] or char.read_ideology
  end
  helper_method :show_ideology?
  
  def show_description?(char)
    session[:user_id] == User.find_by_name('Storyteller').id or char.user_id == session[:user_id] or char.read_description
  end
  helper_method :show_description?
  
  def show_background?(char)
    session[:user_id] == User.find_by_name('Storyteller').id or char.user_id == session[:user_id] or char.read_background
  end
  helper_method :show_background?
  
  def show_deeds?(char)
    session[:user_id] == User.find_by_name('Storyteller').id or char.user_id == session[:user_id] or char.read_deeds
  end
  helper_method :show_deeds?
  
  def show_attributes?(char)
    session[:user_id] == User.find_by_name('Storyteller').id or char.user_id == session[:user_id] or char.read_attributes
  end
  helper_method :show_attributes?
  
  def show_skills?(char)
    session[:user_id] == User.find_by_name('Storyteller').id or char.user_id == session[:user_id] or char.read_skills
  end
  helper_method :show_skills?
  
  def show_advantages?(char)
    session[:user_id] == User.find_by_name('Storyteller').id or char.user_id == session[:user_id] or char.read_advantages
  end
  helper_method :show_advantages?
  
  def show_merits?(char)
    session[:user_id] == User.find_by_name('Storyteller').id or char.user_id == session[:user_id] or char.read_merits
  end
  helper_method :show_merits?
  
  def show_powers?(char)
    session[:user_id] == User.find_by_name('Storyteller').id or char.user_id == session[:user_id] or char.read_powers
  end
  helper_method :show_powers?
  
  def show_equipment?(char)
    session[:user_id] == User.find_by_name('Storyteller').id or char.user_id == session[:user_id] or char.read_equipment
  end
  helper_method :show_equipment?
  
  def show_experience?(char)
    session[:user_id] == User.find_by_name('Storyteller').id or char.user_id == session[:user_id] or char.read_experience
  end
  helper_method :show_experience?
  
  def edit_character?(char)
    session[:user_id] == User.find_by_name('Storyteller').id or char.user_id == session[:user_id]
  end
  helper_method :edit_character?
  
  def is_mortal?(char)
    char.splat.name == "Mortal" or char.splat.name == "Hunter"
  end
  helper_method :is_mortal?

  def is_mage?(char)
    char.splat.name == "Mage"
  end
  helper_method :is_mage?

  def is_werewolf?(char)
    char.splat.name == "Werewolf"
  end
  helper_method :is_werewolf?

  def is_vampire?(char)
    char.splat.name == "Vampire"
  end
  helper_method :is_vampire?

  def is_promethean?(char)
    char.splat.name == "Promethean"
  end
  helper_method :is_promethean?

  def is_changeling?(char)
    char.splat.name == "Changeling"
  end
  helper_method :is_changeling?
  
  def is_geist?(char)
    char.splat.name == "Geist"
  end
  helper_method :is_geist?
end
