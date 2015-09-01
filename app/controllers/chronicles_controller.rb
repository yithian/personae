# Controller for chronicle actions: show/create/edit/etc

class ChroniclesController < ApplicationController
  respond_to :html, :xml
  load_and_authorize_resource

  before_filter :find_chronicle, :only => [:create, :show, :edit, :update, :destroy]

  # GET /chronicles
  # GET /chronicles.xml
  def index
    @chronicles = Chronicle.order('owner_id')

    respond_with @chronicles
  end

  # GET /chronicles/1
  # GET /chronicles/1.xml
  def show
    @characters = @chronicle.characters
    @cliques = Clique.known_to current_user, @chronicle.id


    @pcs = @chronicle.pcs.reject { |c| cannot? :read, c }
    @npcs = @chronicle.find_npcs(current_user, params[:page])

    respond_with @chronicle
  end

  # GET /chronicles/new
  # GET /chronicles/new.xml
  def new
    respond_with @chronicle
  end

  # GET /chronicles/1/edit
  def edit
    @users = ::User.all
  end

  # POST /chronicles
  # POST /chronicles.xml
  def create
    @chronicle = Chronicle.new(chronicle_params)
    @chronicle.owner = current_user

    if @chronicle.save
      flash[:notice] = "Chronicle successfully created"

      user = current_user
      user.selected_chronicle = @chronicle
      user.save
    end

    respond_with @chronicle
  end

  # PUT /chronicles/1
  # PUT /chronicles/1.xml
  def update
    flash[:notice] = "Chronicle successfully updated" if @chronicle.update_attributes(chronicle_params)

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

  # generate strong parameters
  def chronicle_params
    params.require(:chronicle).permit(:name, :description, :owner_id)
  end
end
