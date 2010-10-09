class UsersController < ApplicationController
  respond_to :html, :xml
  # FIXME - is the skip_filter really necessary?
  skip_filter :authorize, :except => [:show, :edit]
  before_filter :find_user, :only => [:new, :show, :edit, :update, :destroy]
  before_filter :permission, :only => [:show, :edit, :update, :destroy]

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
  def find_user
    if params[:action] == "new"
      @user = User.new
    else
      @user = User.find(params[:id])
    end
  end
  
  def permission
    unless @user.can_edit_as_user?(session[:user_id])
      flash[:notice] = "You don't have permission to do that"
      redirect_to :action => :show, :id => session[:user_id]
    end
  end
end
