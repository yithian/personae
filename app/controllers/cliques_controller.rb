class CliquesController < ApplicationController
  respond_to :html, :xml
  before_filter :find_clique, :only => [:show, :edit, :update, :destroy]
  before_filter :show_permission, :only => [:show]
  before_filter :destroy_permission, :only => [:destroy]
  # GET /cliques
  # GET /cliques.xml
  def index
    @cliques = Clique.all.collect do |c|
      c if known_clique?(c)
    end

    respond_with @cliques
  end

  # GET /cliques/1
  # GET /cliques/1.xml
  def show
    respond_with @clique
  end

  # GET /cliques/new
  # GET /cliques/new.xml
  def new
    @clique = Clique.new

    respond_with @clique
  end

  # GET /cliques/1/edit
  def edit
  end

  # POST /cliques
  # POST /cliques.xml
  def create
    @clique = Clique.new(params[:clique])

    flash[:notice] = 'Clique was successfully created.' if @clique.save

    respond_with @clique
  end

  # PUT /cliques/1
  # PUT /cliques/1.xml
  def update
    flash[:notice] = 'Clique was successfully updated.' if @clique.update_attributes(params[:clique])

    respond_with @clique
  end

  # DELETE /cliques/1
  # DELETE /cliques/1.xml
  def destroy
    if @clique != Clique.find_by_name('Solitary')
      @clique.characters.each do |m|
        m.clique_id = Clique.find_by_name('Solitary').id
        m.save
      end
      
      @clique.destroy
    else
      flash[:notice] = 'You cannot destroy this clique.'
    end

    respond_to do |format|
      format.html { redirect_to(cliques_url, :notice => 'Clique was successfully deleted') }
      format.xml  { head :ok }
    end
  end
  
  private
  def find_clique
    @clique = Clique.find(params[:id])
  end
  
  def show_permission
    known_clique = false
    known_clique = true if session[:user_id] == User.find_by_name('Storyteller').id or @clique.user_id == session[:user_id] or @clique.write
    @clique.characters.each do |member|
      known_clique = true if member.read_clique
    end
    
    unless known_clique
      flash[:notice] = "You don't have permission to do that"
      redirect_to :action => :index
    end
  end
  
  def destroy_permission
    unless @clique.user_id == session[:user_id] or session[:user_id] == User.find_by_name("Storyteller").id
      flash[:notice] = "You don't have permission to do that"
      redirect_to :action => :index
    end
  end
end
