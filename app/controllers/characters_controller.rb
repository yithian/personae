class CharactersController < ApplicationController
  respond_to :html, :xml
  before_filter :find_character, :only => [:new, :show, :shapeshift, :edit, :update, :destroy, :preview]
  before_filter :show_permission, :only => [:show]
  before_filter :edit_permission, :only => [:edit, :update, :destroy]
  before_filter :set_params, :only => [:new]
  before_filter :find_lists, :only => [:new, :edit, :update]
  layout "cliques"
  
  # GET /characters
  # GET /characters.xml
  def index
    @characters = Character.all(:order => "clique_id ASC")

    respond_with @characters
  end

  # GET /characters/1
  # GET /characters/1.xml
  def show
    respond_with @character
  end
  
  # GET /characters/preview
  def preview
    respond_to do |format|
      format.js
    end
  end

  # GET /characters/new
  # GET /characters/new.xml
  def new
    respond_with @character
  end

  # GET /characters/1/edit
  def edit
  end
  
  def update_splat
    @splat = Splat.find_by_id(params[:splat_id])
    @nature_list = Nature.find_all_by_splat_id(params[:splat_id])
    @ideology_list = Ideology.find_all_by_splat_id(params[:splat_id])

    respond_to do |format|
      format.js
    end
  end

  def shapeshift
    @form = params[:form]

    respond_to do |format|
      format.js
    end
  end

  # POST /characters
  # POST /characters.xml
  def create
    @character = Character.new(params[:character])
    find_lists

    flash[:notice] = 'Character was successfully created.' if @character.save

    respond_with @character
  end

  # PUT /characters/1
  # PUT /characters/1.xml
  def update
    flash[:notice] = 'Character was successfully updated.' if @character.update_attributes(params[:character])

    respond_with @character
  end

  # DELETE /characters/1
  # DELETE /characters/1.xml
  def destroy
    @character.destroy

    respond_to do |format|
      format.html { redirect_to(characters_url, :notice => 'Character was successfully deleted.') }
      format.xml  { head :ok }
    end
  end
  
  private
  def find_character
    if params[:action] == "new"
      @character = Character.new
    else
      @character = Character.find_by_id(params[:id])
    end
  end
  
  def set_params
    @character.clique_id = params['clique_id'] if params['clique_id']

    if params['ideology_id']
      @character.splat_id = Ideology.find(params['ideology_id']).splat_id
      @character.ideology_id = params['ideology_id']
    end
  end
  
  def find_lists
    @clique_list = Clique.all.collect do |c|
      next unless known_clique?(c)
      [c.name, c.id]
    end
    @clique_list.delete_if do |c|
      c == nil
    end

    @nature_list = Nature.find_all_by_splat_id(@character.splat.id).collect do |n|
      [n.name, n.id]
    end

    @ideology_list = Ideology.find_all_by_splat_id(@character.splat.id).collect do |i|
      [i.name, i.id]
    end

    @splat_list = Splat.all.collect
  end
  
  def edit_permission
    unless @character.user_id == session[:user_id] or session[:user_id] == User.find_by_name("Storyteller").id
      flash[:notice] = "You don't have permission to do that"
      redirect_to :action => :index
    end
  end
  
  def show_permission
    unless session[:user_id] == User.find_by_name('Storyteller').id or @character.user_id == session[:user_id] or @character.read_name
      flash[:notice] = "You don't have permission to do that"
      redirect_to :action => :index
    end
  end
end
