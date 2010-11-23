class ChroniclesController < ApplicationController
  respond_to :html, :xml
  before_filter :find_chronicle, :only => [:new, :show, :edit, :update, :destroy]
  before_filter :create_permission, :only => [:new, :create]
  before_filter :edit_permission, :only => [:edit, :update]
  before_filter :destroy_permission, :only => [:destroy]
  
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
    respond_with @chronicle
  end

  # GET /chronicles/new
  # GET /chronicles/new.xml
  def new
    respond_with @chronicle
  end

  # GET /chronicles/1/edit
  def edit
    @chronicle = Chronicle.find(params[:id])
  end

  # POST /chronicles
  # POST /chronicles.xml
  def create
    @chronicle = Chronicle.new(params[:chronicle])

    flash[:notice] = "Chronicle successfully created" if @chronicle.save

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
  def find_chronicle
    if params[:action] == "new"
      @chronicle = Chronicle.new
    else
      @chronicle = Chronicle.find_by_id(params[:id])
    end
  end
  
  def create_permission
    unless session[:user_id] == User.find_by_name("Storyteller").id
      flash[:notice] = "You don't have permission to do that"
      redirect_to :controller => "chronicles"
    end
  end
  
  def edit_permission
    unless @chronicle.can_edit_as_user?(session[:user_id])
      flash[:notice] = "You don't have permission to do that"
      redirect_to chronicle_path(@chronicle)
    end
  end
  
  def destroy_permission
    unless @chronicle.can_destroy_as_user?(session[:user_id])
      flash[:notice] = "You don't have permission to do that"
      redirect_to :action => :index
    end
  end
end
