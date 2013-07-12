# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  before_filter :chronicle_setup
  before_filter :authenticate_user!, :only => [:new, :create, :edit, :update, :destroy]
  check_authorization :unless => :devise_controller?
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
      case params[:action]
      when 'show'
        target = chronicle_cliques_path(exception.subject.chronicle)
      else
        target = chronicle_clique_path(exception.subject.chronicle, exception.subject)
      end
    when "Character"
      case params[:action]
      when 'show'
        target = chronicle_characters_path(exception.subject.chronicle)
      else
        target = chronicle_character_path(exception.subject.chronicle, exception.subject)
      end
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

  # since users who aren't logged in won't have a current_user
  # we need to stick a value in their session data to keep track
  # of which chronicle they're viewing.
  # 
  # this also preps a couple variables used everywhere
  def chronicle_setup
    if params[:controller] == 'characters' and (params[:action] == 'new' or params[:action] == 'edit')
      @action = update_chronicle_chronicle_characters_path
    else
      @action = change_selected_chronicle_chronicles_path
    end

    @selected_chronicles = []

    if user_signed_in?
      if current_user.admin?
        @selected_chronicles = Chronicle.all
      else
        @selected_chronicles = current_user.characters.collect { |c| c.chronicle }
        @selected_chronicles += current_user.chronicles
        @selected_chronicles.uniq!
      end

      @chronicle = Chronicle.where(:id => params[:chronicle_id])
      @selected_chronicle = current_user.selected_chronicle
    else
      @chronicle = Chronicle.where(:id => params[:chronicle_id])
      @selected_chronicle = Chronicle.find_by_id(session[:selected_chronicle_id]) || Chronicle.all.first
    end

    @selected_chronicles << Chronicle.new(:name => "--------")
    @selected_chronicles << Chronicle.new(:name => "New chronicle")
  end
end
