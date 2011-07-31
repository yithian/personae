# The services controller will handle enabling and
# disabling external services such as Obsidian Portal
class ServicesController < ApplicationController
  include MageHand
  respond_to :html, :xml
  load_and_authorize_resource :class => false
  before_filter :obsidian_portal_login_required, :only => [:obsidian_connect]

  # POST /services/obsidian_connect
  def obsidian_connect
    user = current_user
    user.obsidian_user_id = obsidian_portal.current_user.id
    user.obsidian_user_name = obsidian_portal.current_user.username

    user.save

    redirect_to root_path
  end

  # POST /services/obsidian_disconnect
  def obsidian_disconnect
    user = current_user
    user.obsidian_user_id = nil

    user.save

    redirect_to root_path
  end
end
