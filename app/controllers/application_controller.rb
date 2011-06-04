# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  # before_filter :authorize, :except => [:login, :logout, :forgot_username, :forgot_password, :reset_password]
  before_filter :authenticate_user!
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  protected
  # Prompts for authentication if not logged in and redirects to original destination.
  def authorize
    unless User.find_by_id(session[:user_id])
      session[:original_uri] = request.fullpath
      flash[:notice] = "Please log in"
      # redirect_to :controller => :admin, :action => :login
    end
  end
end
