# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  before_filter :chronicle_setup
  before_filter :authenticate_user!, :only => [:new, :create, :edit, :update, :destroy]
  check_authorization :unless => :devise_controller?
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  
  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "Access denied!"
    
    case exception.subject.class.name
    when "Symbol" # The admin controller has no model, and thus appears as a symbol
      if user_signed_in?
        target = root_path
      else
        target = new_user_session_path
      end
    when "Comment"
      target = chronicle_character_path(exception.subject.character.chronicle, exception.subject.character)
    when "Clique"
      target = chronicle_clique_path(exception.subject.chronicle, exception.subject)
    when "Character"
      target = chronicle_character_path(exception.subject.chronicle, exception.subject)
    else
      target = exception.subject
    end
    
    redirect_to target
  end
  
  protected
  # returns true if obsidian portal integration is running via MageHand
  # and the user has linked his/her account
  def obsidian_enabled?
    not SERVICES['obsidianportal']['consumer_key'].empty? and user_signed_in? and not current_user.obsidian_user_id.nil?
  end
  
  # allows access to helper methods. example:
  # help.selected_chronicle_id(user, session)
  def help
    Helper.instance
  end
  
  # exists only to allow access to helper methods
  class Helper
    include Singleton
    include ApplicationHelper
  end

  # since users who aren't logged in won't have a current_user
  # we need to stick a value in their session data to keep track
  # of which chronicle they're viewing.
  # 
  # this also preps a couple variables used everywhere
  def chronicle_setup
    @chronicles = Chronicle.all
    @chronicles << Chronicle.new(:name => "New chronicle")
    
    if params[:controller] == 'characters' and (params[:action] == 'new' or params[:action] == 'edit')
      @action = update_chronicle_chronicle_characters_path
    else
      @action = change_selected_chronicle_chronicles_path
    end

    unless current_user.nil?
      @selected_chronicle = current_user.selected_chronicle
    else
      @selected_chronicle = Chronicle.find_by_id(session[:selected_chronicle_id]) || Chronicle.first
    end
  end
end
