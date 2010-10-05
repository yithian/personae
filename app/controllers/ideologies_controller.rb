class IdeologiesController < ApplicationController
  respond_to :html, :xml
  before_filter :find_ideology, :only => [:show, :edit, :update, :destroy]
  before_filter :permission, :only => [:create, :edit, :update, :destroy]
  before_filter :show_permission, :only => [:show]
  
  # GET /ideologies
  # GET /ideologies.xml
  def index
    @ideologies = Ideology.all.collect { |i| i if known_ideology?(i) }
    @ideologies.delete_if { |i| i == nil }

    respond_with @ideologies
  end

  # GET /ideologies/1
  # GET /ideologies/1.xml
  def show
    respond_with @ideology
  end

  # GET /ideologies/new
  # GET /ideologies/new.xml
  def new
    @ideology = Ideology.new

    respond_with @ideology
  end

  # GET /ideologies/1/edit
  def edit
  end

  # POST /ideologies
  # POST /ideologies.xml
  def create
    @ideology = Ideology.new(params[:ideology])

    flash[:notice] = 'Ideology was successfully created.' if @ideology.save

    respond_with @ideology
  end

  # PUT /ideologies/1
  # PUT /ideologies/1.xml
  def update
    flash[:notice] = 'Ideology was successfully updated.' if @ideology.update_attributes(params[:ideology])

    respond_with @ideology
  end

  # DELETE /ideologies/1
  # DELETE /ideologies/1.xml
  def destroy
    if @ideology.id != Ideology.find_by_name('Mortal').id
      @ideology.characters.each do |m|
        m.ideology_id = Ideology.find_by_name('Mortal').id
        m.save
      end

      @ideology.destroy
    else
      flash[:notice] = 'Cannot delete this Ideology'
    end

    respond_to do |format|
      format.html { redirect_to(ideologies_url, :notice => 'Ideology successfully deleted.') }
      format.xml  { head :ok }
    end
  end
  
  private
  def find_ideology
    @ideology = Ideology.find(params[:id])
  end
  
  def permission
    unless session[:user_id] == User.find_by_name("Storyteller").id
      flash[:notice] = "You don't have permission to do that"
      redirect_to :action => :index
    end
  end
  
  def show_permission
    known_ideology = false
    known_ideology = true if session[:user_id] == User.find_by_name('Storyteller').id
    @ideology.characters.each do |member|
      known_ideology = true if member.read_ideology
    end
    
    unless known_ideology
      flash[:notice] = "You don't have permission to do that"
      redirect_to :action => :index
    end
  end
end
