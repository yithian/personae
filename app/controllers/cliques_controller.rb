# Controller for clique actions: show/create/edit/etc

class CliquesController < ApplicationController
  respond_to :html, :xml
  load_and_authorize_resource

  before_action :find_clique, :only => [:new, :show, :edit, :update, :destroy]
  before_action :set_params, :only => [:new]
  before_action :find_lists, :only => [:new, :edit, :update]

  # GET /cliques
  # GET /cliques.xml
  def index
    if user_signed_in?
      @cliques = Clique.known_to current_user, @chronicle.id
    else
      @cliques = Clique.known_to User.new, @chronicle.id
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
    respond_with @clique
  end

  # GET /cliques/1/edit
  def edit
    respond_with @clique
  end

  # POST /cliques
  # POST /cliques.xml
  def create
    @clique = Clique.new(clique_params)
    @clique.owner = current_user

    flash[:notice] = 'Clique was successfully created.' if @clique.save

    respond_with(@clique.chronicle, @clique)
  end

  # PUT /cliques/1
  # PUT /cliques/1.xml
  def update
    if @clique.update_attributes(clique_params)
      # updates the clique's characters' chronicle as well
      @clique.characters.each do |character|
        character.chronicle = @clique.chronicle
        character.save
      end if current_user.super_user?(@clique.chronicle) and current_user.super_user?(Chronicle.find_by_id(params[:clique][:chronicle_id] ))

      flash[:notice] = 'Clique was successfully updated.'
    end

    respond_with(@clique.chronicle, @clique)
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
      format.html { redirect_to(chronicle_cliques_url(@clique.chronicle), :notice => 'Clique was successfully deleted') }
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

  # generate strong parameters
  def clique_params
    params.require(:clique).permit(:name, :chronicle_id, :territory, :description, :write, :owner_id)
  end
end
