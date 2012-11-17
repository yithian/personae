# Controller for chronicle actions: show/create/edit/etc

class ChroniclesController < ApplicationController
  include MageHand
  respond_to :html, :xml
  load_and_authorize_resource
  
  before_filter :obsidian_portal_login_required, :only => [:new, :create, :edit, :update], :if => :obsidian_enabled?
  before_filter :find_campaign, :only => [:new, :create, :show, :edit, :update], :if => :obsidian_enabled?
  before_filter :find_chronicle, :only => [:create, :show, :edit, :update, :destroy]
  
  # GET /chronicles
  # GET /chronicles.xml
  def index
    respond_with @chronicle
  end

  # GET /chronicles/1
  # GET /chronicles/1.xml
  def show
    @characters = @chronicle.characters
    @cliques = @chronicle.cliques

    @pcs = @chronicle.pcs.reject { |c| cannot? :read, c }
    @npcs = @chronicle.find_npcs(current_user, params[:page])
    
    respond_with @chronicle
  end

  # GET /chronicles/new
  # GET /chronicles/new.xml
  def new
    obsidian_campaigns if obsidian_enabled?
    
    respond_with @chronicle
  end

  # GET /chronicles/1/edit
  def edit
    if obsidian_enabled?
      obsidian_campaigns

      @chronicle.description = @campaign.wiki_pages[0].body unless @campaign.nil?
    end
    
    @users = ::User.all
  end

  # POST /chronicles
  # POST /chronicles.xml
  def create
    @chronicle = Chronicle.new(params[:chronicle])
    @chronicle.owner = current_user

    if @chronicle.save
      flash[:notice] = "Chronicle successfully created"
      
      user = current_user
      user.selected_chronicle = @chronicle
      user.save
    end

    unless @campaign.nil?
      json_page = JSON.generate({:wiki_page => {:body => @chronicle.description }})
      obsidian_portal.access_token.put("/v1/campaigns/#{@campaign.id}/wikis/#{@campaign.wiki_pages[0].id}.json", json_page)
    end if obsidian_enabled?

    respond_with @chronicle
  end

  # PUT /chronicles/1
  # PUT /chronicles/1.xml
  def update
    flash[:notice] = "Chronicle successfully updated" if @chronicle.update_attributes(params[:chronicle])

    unless @campaign.nil?
      json_page = JSON.generate({:wiki_page => {:body => @chronicle.description }})
      obsidian_portal.access_token.put("/v1/campaigns/#{@campaign.id}/wikis/#{@campaign.wiki_pages[0].id}.json", json_page)
    end if obsidian_enabled?

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
  
  # POST /chronicles/change_selected_chronicle
  def change_selected_chronicle
    # if an empty string is passed in here, create a new chronicle
    # otherwise, display the new @selected_chronicle
    if params[:new_chronicle_id].empty?
      @target = new_chronicle_path
    else
      @selected_chronicle = Chronicle.find_by_id(params[:new_chronicle_id])
    
      if user_signed_in?
        current_user.selected_chronicle = @selected_chronicle
        current_user.save
      else
        session[:selected_chronicle_id] = @selected_chronicle.id
      end
      
      @target = chronicle_path(@selected_chronicle)
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
    @campaign = MageHand::Campaign.find(@chronicle.obsidian_campaign_id) unless @chronicle.obsidian_campaign_id == '0' or @chronicle.obsidian_campaign_id.nil?
  end
  
  # sets up a variable to hold an array of obsidian portal campaign names
  # and ids
  def obsidian_campaigns
    @campaigns = obsidian_portal.current_user.campaigns.collect do |campaign|
      [campaign.name, campaign.id]
    end
    @campaigns.insert(0, ['-', 0])
  end
end
