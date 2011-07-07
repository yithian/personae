# Controller for ideology actions: show/create/edit/etc

class IdeologiesController < ApplicationController
  respond_to :html, :xml
  load_and_authorize_resource
  before_filter :find_ideology, :only => [:new, :show, :edit, :update, :destroy]
  before_filter :show_permission, :only => [:show]
  before_filter :set_params, :only => [:new]
  before_filter :find_lists, :only => [:new, :create, :edit, :update]
  
  # GET /ideologies
  # GET /ideologies.xml
  def index
    @ideologies = Ideology.all.collect { |i| i if i.is_known_to_user?(current_user) }
    @ideologies.delete_if { |i| i == nil }

    respond_with @ideologies
  end

  # GET /ideologies/1
  # GET /ideologies/1.xml
  def show
    respond_with @ideology
  end

  # GET /ideologies/new
  # GET /ideologies/new.xml
  def new
    respond_with @ideology
  end

  # GET /ideologies/1/edit
  def edit
  end

  # POST /ideologies
  # POST /ideologies.xml
  def create
    @ideology = Ideology.new(params[:ideology])

    flash[:notice] = 'Ideology was successfully created.' if @ideology.save

    respond_with @ideology
  end

  # PUT /ideologies/1
  # PUT /ideologies/1.xml
  def update
    flash[:notice] = 'Ideology was successfully updated.' if @ideology.update_attributes(params[:ideology])

    respond_with @ideology
  end

  # DELETE /ideologies/1
  # DELETE /ideologies/1.xml
  def destroy
    if @ideology != Ideology.find_by_name('Mortal')
      @ideology.characters.each do |m|
        m.ideology_id = Ideology.find_by_name('Mortal')
        m.save
      end

      @ideology.destroy
    else
      flash[:notice] = 'Cannot delete this Ideology'
    end

    respond_to do |format|
      format.html { redirect_to(ideologies_url, :notice => 'Ideology successfully deleted.') }
      format.xml  { head :ok }
    end
  end
  
  private
  # Sets up an ideology object based on an id passed by url or
  # creates a new (empty) object
  def find_ideology
    if params[:action] == "new"
      @ideology = Ideology.new
    else
      @ideology = Ideology.find_by_id(params[:id])
    end
  end
  
  # Sets values based on ids passed by url. Used to add an ideology
  # to a splat.
  def set_params
    @ideology.splat_id = params['splat_id'] if params['splat_id']
  end
  
  # Creates a list of all splats. Used to create a new ideology.
  def find_lists
    @splat_list = Splat.all.collect
  end

  # Allows or denies access to create, edit or destroy an ideology
  # based on wether or not the user is the Storyteller user.
  def permission
    unless current_user.admin?
      flash[:notice] = "You don't have permission to do that"
      redirect_to ideologies_path
    end
  end
  
  # Allows or denies access to an ideology page based on
  # Ideology.is_known_to_user?
  def show_permission
    unless @ideology.is_known_to_user?(current_user)
      flash[:notice] = "You don't have permission to do that"
      redirect_to ideologies_path
    end
  end
end
