# Controller for user actions: create/edit/show/etc

class UsersController < ApplicationController
  respond_to :html, :xml
  skip_filter :authorize, :only => [:new, :create]
  before_filter :find_user, :only => [:new, :show, :edit, :update, :destroy]
  before_filter :index_permission, :only => [:index]
  before_filter :permission, :only => [:show, :edit, :update, :destroy]

  # GET /users/
  def index
    @users = User.all.collect { |u| u if u.can_edit_as_user?(session[:user_id]) }
    @users.delete_if { |u| u == nil }
    
    respond_with @users
  end
  
  # GET /users/1
  # GET /users/1.xml
  def show
    respond_with @user
  end

  # GET /users/new
  # GET /users/new.xml
  def new
    respond_with @user
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.xml
  def create
    @user = User.new(params[:user])

    flash[:notice] = "User #{@user.name} was successfully created." if @user.save

    respond_with @user
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    flash[:notice] = "User #{@user.name} was successfully updated." if @user.update_attributes(params[:user])
    
    respond_with @user
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(:controller => "characters") }
      format.xml  { head :ok }
    end
  end
  
  private
  # Sets up a user object based on an id passed by url or creates
  # a new (empty) user.
  def find_user
    if params[:action] == "new"
      @user = User.new
    else
      @user = User.find(params[:id])
    end
  end
  
  # Allows or denies access to a listing of all users based on
  # wether or not the user is the Storyteller user.
  def index_permission
    unless User.find(session[:user_id]).id == User.find_by_name("Storyteller").id
      flash[:notice] = "You don't have permission to do that"
      redirect_to :action => "show", :id => session[:user_id]
    end
  end
  
  def permission
    unless @user.can_edit_as_user?(session[:user_id])
      flash[:notice] = "You don't have permission to do that"
      redirect_to :action => :show, :id => session[:user_id]
    end
  end
end
