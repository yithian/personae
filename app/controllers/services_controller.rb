# The services controller will handle enabling and
# disabling external services such as Obsidian Portal
class ServicesController < ApplicationController
  include MageHand
  respond_to :html, :xml
  skip_authorization_check
  
  before_filter :obsidian_portal_login_required, :only => [:obsidian_connect]
  before_filter :ensure_logged_in

  # POST /services/obsidian_connect
  def obsidian_connect
    authorize! :obsidian, :connect

    user = current_user
    user.obsidian_user_id = obsidian_portal.current_user.id
    user.obsidian_user_name = obsidian_portal.current_user.username

    user.save

    redirect_to root_path
  end

  # POST /services/obsidian_disconnect
  def obsidian_disconnect
    authorize! :obsidian, :disconnect

    user = current_user
    user.obsidian_user_id = nil
    user.obsidian_user_name = ''

    user.save

    redirect_to root_path
  end

  protected
  # due to some cancan quirks, this check stops users that aren't
  # logged in from connecting or disconnecting to obsidian portal
  def ensure_logged_in
    unless user_signed_in?
      flash[:alert] = "You need to sign in or sign up before continuing."
      redirect_to new_user_session_path
    end
  end
end
