# Controller for character actions: show/create/edit/etc

class CharactersController < ApplicationController
  include MageHand
  respond_to :html, :xml
  load_and_authorize_resource
  before_filter :obsidian_portal_login_required, :only => [:new, :create, :edit, :update, :destroy], :if => :obsidian_enabled?
  before_filter :find_character, :only => [:new, :show, :shapeshift, :edit, :update, :save_notes, :save_current, :destroy, :preview]
  before_filter :show_permission, :only => [:show]
  before_filter :set_params, :only => [:new]
  before_filter :find_lists, :only => [:new, :edit, :update]
  before_filter :expire_cache, :only => [:index]
  
  # GET /characters
  # GET /characters.xml
  def index
    @chronicles = Chronicle.all.collect
    @selected_chronicle_id = help.selected_chronicle_id(current_user, session)

    chronicle = Chronicle.find_by_id(@selected_chronicle_id)
    @pcs = chronicle.pcs.reject { |c| not c.show_name_to_user?(current_user) }
    @npcs = chronicle.npcs.reject { |c| not c.show_name_to_user?(current_user) }
    
    if user_signed_in?
      @characters = Character.known_to current_user
    else
      # this is an awful hack because User.new seemed to be conflicting with MageHand::User.new (which doesn't exist?)
      @characters = Character.known_to 0, @selected_chronicle_id
    end

    respond_with @characters, @selected_chronicle_id, @pcs, @npcs
  end
  
  # POST /characters/change_chronicle
  def change_chronicle
    # this bit of weirdness is to ensure the chronicle actually exists
    @selected_chronicle_id = Chronicle.find_by_id(params[:chronicle_id]).id
    
    chronicle = Chronicle.find_by_id(@selected_chronicle_id)
    @pcs = chronicle.pcs.reject { |c| not c.show_name_to_user?(current_user) }
    @npcs = chronicle.npcs.reject { |c| not c.show_name_to_user?(current_user) }
    
    if user_signed_in?
      current_user.selected_chronicle = Chronicle.find_by_id(@selected_chronicle_id)
      current_user.save
    else
      session[:selected_chronicle_id] = @selected_chronicle_id
    end

    @characters = Character.known_to current_user, @selected_chronicle_id
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
    obsidian_characters if obsidian_enabled?
    
    respond_with @character
  end

  # GET /characters/1/edit
  def edit
    obsidian_characters if obsidian_enabled?
    @users = ::User.all
  end
  
  # POST /characters/update_splat
  def update_splat
    @splat = Splat.find_by_id(params[:splat_id])
    @nature_list = Nature.find_all_by_splat_id(@splat.id)
    @subnature_list = Subnature.list_for_nature(@nature_list.first).collect
    @ideology_list = Ideology.find_all_by_splat_id(@splat.id)

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
    @chronicle = Chronicle.find_by_id(params[:chronicle_id])
    @clique_list = Clique.known_to(current_user, @chronicle.id).collect do |c|
      [c.name, c.id]
    end
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

    if @character.save
      flash[:notice] = 'Character was successfully created.' 
      
      obsidian_save if obsidian_enabled?
    end

    respond_with @character
  end

  # PUT /characters/1
  # PUT /characters/1.xml
  #
  # this will also sync a character's sheet to obsidian portal,
  # if an obsidian_character_id is specified
  def update
    @character.vice = params[:character_vice].join(" ") if params[:character_vice]
    
    if @character.update_attributes(params[:character])
      flash[:notice] = 'Character was successfully updated.'
      
      obsidian_save if obsidian_enabled?      
    end
    
    respond_with @character
  end
  
  # PUT /characters/1/save_notes
  # 
  # this will animate saving the notes on a character's page
  def save_notes
    @character.notes = params[:character][:notes]
    @successful = @character.save
  end
  
  # PUT /characters/1/save_current
  #
  # this will only save the current_health and current_willpower
  # attributes (and not do anything with the notice area)
  def save_current
    @character.current_health = params[:character][:current_health] if params[:character][:current_health]
    @character.current_willpower = params[:character][:current_willpower] if params[:character][:current_willpower]
    @character.current_fuel = params[:character][:current_fuel] if params[:character][:current_fuel]
    @character.infernal_will = params[:character][:infernal_will] if params[:character][:infernal_will]
    
    if @character.save
      head :success
    else
      head 500
    end
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
      @clique_list = Clique.known_to(current_user, params[:chronicle_id]).collect do |clique|
        [clique.name, clique.id]
      end
    else
      @clique_list = Clique.known_to(current_user, @character.chronicle_id).collect do |clique|
        [clique.name, clique.id]
      end
    end
    
    @nature_list = Nature.find_all_by_splat_id(@character.splat.id).collect
    @subnature_list = Subnature.list_for_nature(@character.nature)
    @ideology_list = Ideology.find_all_by_splat_id(@character.splat.id).collect
    
    @splat_list = Splat.all.collect
    @chronicle_list = Chronicle.all.collect
  end
  
  # sets up a variable of obsidian portal character names and ids
  # for use in a select tag
  def obsidian_characters
    unless @character.chronicle.obsidian_campaign_id == '0' or @character.chronicle.obsidian_campaign_id.nil? 
      @obsidian_characters = JSON.parse(obsidian_portal.access_token.get("/v1/campaigns/#{@character.chronicle.obsidian_campaign_id}/characters.json").body).collect { |c| [c["name"], c["id"]] }
      @obsidian_characters.insert(0, ["-", 0])
      @obsidian_characters << ["Create new", -1]
    end
  end
  
  # saves a character to obsidian portal if appropriate
  def obsidian_save
    json_character = JSON.generate({:character => {:name => @character.name, :bio => @character.obsidian_bio, :description => @character.obsidian_description, :is_game_master_only => (not @character.read_name), :is_player_character => @character.pc, :tagline => @character.concept}})
    
    case @character.obsidian_character_id 
    when "0"
      # do not sync
      return
    when "-1"
      # create a new character
      result =   obsidian_portal.access_token.post("/v1/campaigns/#{@character.chronicle.obsidian_campaign_id}/characters.json", json_character)
    else
      # update existing character
      result =  obsidian_portal.access_token.put("/v1/campaigns/#{@character.chronicle.obsidian_campaign_id}/characters/#{@character.obsidian_character_id}.json", json_character)
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
