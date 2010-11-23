class IdeologiesController < ApplicationController
  respond_to :html, :xml
  before_filter :find_ideology, :only => [:new, :show, :edit, :update, :destroy]
  before_filter :permission, :only => [:new, :create, :edit, :update, :destroy]
  before_filter :show_permission, :only => [:show]
  before_filter :find_lists, :only => [:new, :create, :edit, :update]
  
  # GET /ideologies
  # GET /ideologies.xml
  def index
    @ideologies = Ideology.all.collect { |i| i if i.is_known_to_user?(session[:user_id]) }
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
    if params[:action] == "new"
      @ideology = Ideology.new
    else
      @ideology = Ideology.find_by_id(params[:id])
    end
  end
  
  def find_lists
    @splat_list = Splat.all.collect
  end

  def permission
    unless session[:user_id] == User.find_by_name("Storyteller").id
      flash[:notice] = "You don't have permission to do that"
      redirect_to :action => "index"
    end
  end
  
  def show_permission
    unless @ideology.is_known_to_user?(session[:user_id])
      flash[:notice] = "You don't have permission to do that"
      redirect_to :action => "index"
    end
  end
end
