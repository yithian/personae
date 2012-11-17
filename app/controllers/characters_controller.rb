# Controller for character actions: show/create/edit/etc

class CharactersController < ApplicationController
  include MageHand
  respond_to :html, :xml
  load_and_authorize_resource
  
  before_filter :obsidian_portal_login_required, :only => [:new, :create, :edit, :update, :destroy], :if => :obsidian_enabled?
  before_filter :find_character, :only => [:new, :show, :shapeshift, :edit, :update, :save_notes, :save_current, :destroy, :preview]
  before_filter :set_params, :only => [:new]
  before_filter :find_lists, :only => [:new, :edit, :update]
  
  skip_before_filter :chronicle_setup, :only => [:roll, :preview, :shapeshift, :possess, :update_splat, :update_nature, :update_chronicle]
  
  # GET /characters
  # GET /characters.xml
  def index
    @pcs = @selected_chronicle.pcs.reject { |c| cannot? :read, c }
    @npcs = @selected_chronicle.find_npcs(current_user, params[:page])
    
    respond_with @selected_chronicle, @pcs, @npcs
  end

  # GET /characters/1
  # GET /characters/1.xml
  def show
    respond_with @character
  end
  
  # POST /characters/1/roll
  def roll
    @dice_count = 0
    reroll = 10
    cancel = false
    @error = false
    
    params[:dice_count].split(/\s*\+\s*/).each { |d| @dice_count += d.to_i }
    
    case params[:reroll]
    when '10', '9', '8'
      reroll = params[:reroll].to_i
    when 'rote'
      reroll = 0
    end
    
    cancel = true if params[:cancel]
    
    result = DiceRoller::DicePool.new(0, 0, 0, @dice_count).roll_pool
    
    if @dice_count <= 50
      @successes = result.successes(8, reroll, cancel)
      @dice_results = result.ten_result
    else
      @error = true
    end
    
    respond_to do |format|
      format.js
    end
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
  
  # GET /characters/possess
  def possess
    @possessed = params[:active]
    
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
    @chronicle = Chronicle.find_by_id(params[:new_chronicle_id])
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

    respond_with(@character.chronicle, @character)
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
    
    respond_with(@character.chronicle, @character)
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
    @character.current_infernal_will = params[:character][:current_infernal_will] if params[:character][:current_infernal_will]
    
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
      format.html { redirect_to(chronicle_characters_url(Chronicle.find(@selected_chronicle.id)), :notice => 'Character was successfully deleted.') }
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
end
