class IdeologiesController < ApplicationController
  before_filter :find_ideology, :only => [:show, :edit, :update, :destroy]
  before_filter :permission, :only => [:create, :edit, :update, :destroy]
  before_filter :show_permission, :only => [:show]
  layout "cliques"
  
  # GET /ideologies
  # GET /ideologies.xml
  def index
    @ideologies = Ideology.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @ideologies }
    end
  end

  # GET /ideologies/1
  # GET /ideologies/1.xml
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @ideology }
    end
  end

  # GET /ideologies/new
  # GET /ideologies/new.xml
  def new
    @ideology = Ideology.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @ideology }
    end
  end

  # GET /ideologies/1/edit
  def edit
  end

  # POST /ideologies
  # POST /ideologies.xml
  def create
    @ideology = Ideology.new(params[:ideology])

    respond_to do |format|
      if @ideology.save
        flash[:notice] = 'Ideology was successfully created.'
        format.html { redirect_to(@ideology) }
        format.xml  { render :xml => @ideology, :status => :created, :location => @ideology }
      else
        format.html { render :action => :new }
        format.xml  { render :xml => @ideology.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /ideologies/1
  # PUT /ideologies/1.xml
  def update
    respond_to do |format|
      if @ideology.update_attributes(params[:ideology])
        flash[:notice] = 'Ideology was successfully updated.'
        format.html { redirect_to(@ideology) }
        format.xml  { head :ok }
      else
        format.html { render :action => :edit }
        format.xml  { render :xml => @ideology.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /ideologies/1
  # DELETE /ideologies/1.xml
  def destroy
    @ideology.characters.each do |m|                                                                                                                           
        m.ideology_id = Ideology.find_by_name('Mortal').id
        m.save
    end

    @ideology.destroy

    respond_to do |format|
      format.html { redirect_to(ideologies_url) }
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
    @ideology.characters.each do |member|
      known_ideology = true if member.read_ideology or session[:user_id] == User.find_by_name('Storyteller').id
    end
    
    unless known_ideology
      flash[:notice] = "You don't have permission to do that"
      redirect_to :action => :index
    end
  end
end
