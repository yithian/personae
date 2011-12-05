# Controller for nature actions: show/create/edit/etc

class NaturesController < ApplicationController
  respond_to :html, :xml
  load_and_authorize_resource
  before_filter :find_nature, :only => [:new, :show, :edit, :update, :destroy]
  before_filter :set_params, :only => [:new]
  before_filter :find_lists, :only => [:new, :create, :edit, :update]
  
  # GET /natures
  # GET /natures.xml
  def index
    @natures = Nature.all

    respond_with @natures
  end

  # GET /natures/1
  # GET /natures/1.xml
  def show
    respond_with @nature
  end

  # GET /natures/new
  # GET /natures/new.xml
  def new
    respond_with @nature
  end

  # GET /natures/1/edit
  def edit
  end

  # POST /natures
  # POST /natures.xml
  def create
    @nature = Nature.new(params[:nature])

    flash[:notice] = 'Nature was successfully created.' if @nature.save

    respond_with @nature
  end

  # PUT /natures/1
  # PUT /natures/1.xml
  def update
    flash[:notice] = 'Nature was successfully updated.' if @nature.update_attributes(params[:nature])

    respond_with @nature
  end

  # DELETE /natures/1
  # DELETE /natures/1.xml
  def destroy
    if @nature != Nature.find_by_name('Mortal')
      @nature.characters.each do |m|
        m.nature_id = Nature.find_by_name('Mortal')
        m.save
      end

      @nature.destroy
    else
      flash[:notice] = 'Cannot delete this Nature'
    end

    respond_to do |format|
      format.html { redirect_to(natures_url, :notice => 'Nature successfully deleted.') }
      format.xml  { head :ok }
    end
  end
  
  private
  # Sets up an nature object based on an id passed by url or
  # creates a new (empty) object
  def find_nature
    if params[:action] == "new"
      @nature = Nature.new
    else
      @nature = Nature.find_by_id(params[:id])
    end
  end
  
  # Sets values based on ids passed by url. Used to add an nature
  # to a splat.
  def set_params
    @nature.splat_id = params['splat_id'] if params['splat_id']
  end
  
  # Creates a list of all splats. Used to create a new nature.
  def find_lists
    @splat_list = Splat.all.collect
  end
end
