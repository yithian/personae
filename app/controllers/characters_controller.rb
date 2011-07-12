# Controller for character actions: show/create/edit/etc

class CharactersController < ApplicationController
  respond_to :html, :xml
  load_and_authorize_resource
  before_filter :find_character, :only => [:new, :show, :shapeshift, :edit, :update, :destroy, :preview]
  before_filter :show_permission, :only => [:show]
  before_filter :set_params, :only => [:new]
  before_filter :find_lists, :only => [:new, :edit, :update]
  
  # GET /characters
  # GET /characters.xml
  def index
    @chronicles = Chronicle.all.collect
    
    @characters = Character.known_to(current_user)

    respond_with @characters
  end
  
  # POST /characters/change_chronicle
  def change_chronicle
    current_user.selected_chronicle = Chronicle.find_by_id(params[:chronicle_id])
    current_user.save
    
    @characters = Character.known_to current_user
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
  
  # POST /characters/update_splat
  def update_splat
    @splat = Splat.find_by_id(params[:splat_id])
    @nature_list = Nature.find_all_by_splat_id(params[:splat_id])
    @subnature_list = Subnature.list_for_nature(@nature_list.first).collect
    @ideology_list = Ideology.find_all_by_splat_id(params[:splat_id])

    respond_to do |format|
      format.js
    end
  end
  
  # POST /characters/update_nature
  def update_nature
    @nature = Nature.find_by_id(params[:nature_id])
    @subnature_list = Subnature.list_for_nature(@nature)

    respond_to do |format|
      format.js
    end
  end
  
  # POST /characters/update_chronicle
  def update_chronicle
    @clique_list = Clique.known_to(current_user, params[:chronicle_id])
    @chronicle = Chronicle.find_by_id(params[:chronicle_id])
  end

  # POST /characters/shapeshift
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
    @character.owner = current_user
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
  # Sets up a character object based on the id passed by url. If none is given,
  # creates a new (empty) object.
  def find_character
    if params[:action] == "new"
      @character = Character.new
    else
      @character = Character.find_by_id(params[:id])
    end
  end
  
  # Sets values to what is passed by url. Used to add a new character
  # to an existing chronicle, clique, etc.
  def set_params
    @character.clique_id = params['clique_id'] if params['clique_id']
    @character.splat_id = params['splat_id'] if params['splat_id']
    @character.chronicle_id = params['chronicle_id'] if params['chronicle_id']
    @character.nature_id = params['nature_id'] if params['nature_id']

    if params['ideology_id']
      @character.splat_id = Ideology.find(params['ideology_id']).splat_id
      @character.ideology_id = params['ideology_id']
    end
  end
  
  # Restricts dropdowns to only include information appropriate to the character's
  # chronicle and splat.
  def find_lists
    if params[:chronicle_id]
      @clique_list = Clique.known_to current_user, params[:chronicle_id]
    else
      @clique_list = Clique.known_to current_user
    end
    
    @nature_list = Nature.find_all_by_splat_id(@character.splat.id).collect
    @subnature_list = Subnature.list_for_nature(@character.nature)
    @ideology_list = Ideology.find_all_by_splat_id(@character.splat.id).collect
    
    @splat_list = Splat.all.collect
    @chronicle_list = Chronicle.all.collect
  end
  
  # Allows or denies access to edit a character based on Character#can_edit_as_user?
  def edit_permission
    unless @character.can_edit_as_user?(current_user)
      flash[:notice] = "You don't have permission to do that"
      redirect_to character_path(@character)
    end
  end
  
  # Allows or denies access to a character page based on Character#show_name_to_user?
  def show_permission
    unless @character.show_name_to_user?(current_user)
      flash[:notice] = "You don't have permission to do that"
      redirect_to characters_path
    end
  end
end
