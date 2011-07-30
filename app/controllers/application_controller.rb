# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
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
      target = character_path(exception.subject.character)
    else
      target = exception.subject
    end
    
    redirect_to target
  end
  
  protected
  # returns true if obsidian portal integration is running via MageHand
  # and the user has linked his/her account
  def obsidian_enabled?
    not SERVICES['obsidianportal']['consumer_key'].empty? and obsidian_portal.logged_in?
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
end
