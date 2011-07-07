# Controller for clique actions: show/create/edit/etc

class CliquesController < ApplicationController
  respond_to :html, :xml
  load_and_authorize_resource
  before_filter :find_clique, :only => [:new, :show, :edit, :update, :destroy]
  before_filter :show_permission, :only => ["show"]
  before_filter :set_params, :only => [:new]
  before_filter :find_lists, :only => [:new, :edit, :update]
  
  # GET /cliques
  # GET /cliques.xml
  def index
    @chronicles = Chronicle.all.collect
    
    @cliques = Clique.find_all_by_chronicle_id(0)
    @cliques = @cliques + Clique.find_all_by_chronicle_id(current_user.selected_chronicle.id).collect { |c| c if c.is_known_to_user?(current_user) }
    @cliques.delete_if { |c| c == nil }

    respond_with @cliques
  end

  # POST /cliques/change_chronicle
  def change_chronicle
    current_user.selected_chronicle = Chronicle.find_by_id(params[:chronicle_id])
    current_user.save

    @chronicle = Chronicle.find_by_id(current_user.selected_chronicle.id)
    @cliques = Clique.find_all_by_chronicle_id(0)
    @cliques = @cliques + Clique.find_all_by_chronicle_id(current_user.selected_chronicle.id).collect { |c| c if c.is_known_to_user?(current_user) }
    @cliques.delete_if { |c| c == nil }
  end

  # GET /cliques/1
  # GET /cliques/1.xml
  def show
    respond_with @clique if @clique.is_known_to_user?(current_user)
  end

  # GET /cliques/new
  # GET /cliques/new.xml
  def new
    respond_with @clique
  end

  # GET /cliques/1/edit
  def edit
    respond_with @clique if @clique.can_edit_as_user?(current_user)
  end

  # POST /cliques
  # POST /cliques.xml
  def create
    @clique = Clique.new(params[:clique])
    @clique.owner = current_user

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
  # Sets up a clique variable based on an id passed by url, or if none
  # was passed, creates a new (empty) clique.
  def find_clique
    if params[:action] == "new"
      @clique = Clique.new
    else
      @clique = Clique.find_by_id(params[:id])
    end
  end

  # Sets values to what is passed by url. Used to add a new character
  # to an existing chronicle.
  def set_params
    @clique.chronicle_id = params['chronicle_id'] if params['chronicle_id']
  end

  # Creates a list of all chronicles. Used to populate a dropdown for moving
  # cliques between chronicles.
  def find_lists
    @chronicle_list = Chronicle.all.collect
  end
  
  # Allows or denies access to a clique page based on Clique#is_known_to_user?
  def show_permission
    unless @clique.is_known_to_user?(current_user)
      flash[:notice] = "You don't have permission to do that"
      redirect_to cliques_path
    end
  end
end
