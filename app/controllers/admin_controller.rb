# The admin controller will handle administrative
# functions, such as managing users with admin access.

class AdminController < ApplicationController
  before_filter :permission, :only => [ :manage ]
  respond_to :html, :xml
  
  # GET /admin/manage
  # GET /admin/manage.xml
  def manage
    # set selected users as admins. this will most
    # likely not scale well and should probably be
    # replaced
    if request.method == "POST"
      params[:admin_ids] = [] unless defined?(params[:admin_ids])

      User.all.each do |user|
        if params[:admin_ids].include? user.id
          user.admin = true
        else
          user.admin = false unless user.name == "Storyteller"
        end
        
        user.save
      end
    end
    
    @users = User.all.delete_if { |u| u.name == "Storyteller" }
    
    respond_with @users
  end
  
  private
  def permission
    unless current_user.admin?
      flash[:notice] = "You don't have permission to do that"
      redirect_to root_path
    end
  end
end
