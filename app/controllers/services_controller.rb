# The services controller will handle enabling and
# disabling external services such as Obsidian Portal
class ServicesController < ApplicationController
  include MageHand
  respond_to :html, :xml
  before_filter :obsidian_portal_login_required, :only => [:obsidian_connect]
  before_filter :logged_in?

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

    user.save

    redirect_to root_path
  end

  protected
  # since cancan is providing a temporary user to
  # check permissions, it won't adequately check
  # to see if a user needs to log in.
  def logged_in?
    unless user_signed_in?
      flash[:alert] = "You need to sign in or sign up before continuing."
      redirect_to new_user_session_path
    end
  end
end
