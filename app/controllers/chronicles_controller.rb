# Controller for chronicle actions: show/create/edit/etc

class ChroniclesController < ApplicationController
  respond_to :html, :xml
  load_and_authorize_resource
  before_filter :obsidian_portal_login_required
  before_filter :find_campaign, :only => [:new, :create, :show, :edit, :update]
  before_filter :find_chronicle, :only => [:create, :show, :edit, :update, :destroy]
  
  # GET /chronicles
  # GET /chronicles.xml
  def index
    @chronicles = Chronicle.all

    respond_with @chronicle
  end

  # GET /chronicles/1
  # GET /chronicles/1.xml
  def show
    @characters = @chronicle.characters
    @cliques = @chronicle.cliques
    
    @chronicle.description = @campaign.wiki_pages[0].body_html
    
    respond_with @chronicle
  end

  # GET /chronicles/new
  # GET /chronicles/new.xml
  def new
    @campaigns = obsidian_portal.current_user.campaigns.collect do |campaign|
      [campaign.name, campaign.id]
    end
    @campaigns.insert(0, ['-', '0'])
    
    respond_with @chronicle
  end

  # GET /chronicles/1/edit
  def edit
    @campaigns = obsidian_portal.current_user.campaigns.collect do |campaign|
      [campaign.name, campaign.id]
    end
    @campaigns.insert(0, ['-', '0'])
  end

  # POST /chronicles
  # POST /chronicles.xml
  def create
    @chronicle = Chronicle.new(params[:chronicle])
    @chronicle.owner = current_user

    if @chronicle.save
      flash[:notice] = "Chronicle successfully created"
      
      user = current_user.id
      user.selected_chronicle = @chronicle
      user.save
    end

    respond_with @chronicle
  end

  # PUT /chronicles/1
  # PUT /chronicles/1.xml
  def update
    flash[:notice] = "Chronicle successfully updated" if @chronicle.update_attributes(params[:chronicle])

    respond_with @chronicle
  end

  # DELETE /chronicles/1
  # DELETE /chronicles/1.xml
  def destroy
    @chronicle.destroy

    respond_to do |format|
      format.html { redirect_to(chronicles_url) }
      format.xml  { head :ok }
    end
  end
  
  private
  # Sets up a chronicle variable from an id passed by url, or if none is
  # passed, a new (empty) chronicle.
  def find_chronicle
    if params[:action] == "new"
      @chronicle = Chronicle.new
    else
      @chronicle = Chronicle.find_by_id(params[:id])
    end
  end
  
  # sets up a campaign variable from the obsidian_campaign_id saved in
  # the chronicle
  def find_campaign
    @campaign = MageHand::Campaign.find(@chronicle.obsidian_campaign_id)
  end
end
