class CliquesController < ApplicationController
  before_filter :find_clique, :only => [:show, :edit, :update, :destroy]
  before_filter :permission, :only => [:edit, :update, :destroy]
  # GET /cliques
  # GET /cliques.xml
  def index
    @cliques = Clique.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @cliques }
    end
  end

  # GET /cliques/1
  # GET /cliques/1.xml
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @clique }
    end
  end

  # GET /cliques/new
  # GET /cliques/new.xml
  def new
    @clique = Clique.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @clique }
    end
  end

  # GET /cliques/1/edit
  def edit
  end

  # POST /cliques
  # POST /cliques.xml
  def create
    @clique = Clique.new(params[:clique])

    respond_to do |format|
      if @clique.save
        flash[:notice] = 'Clique was successfully created.'
        format.html { redirect_to(@clique) }
        format.xml  { render :xml => @clique, :status => :created, :location => @clique }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @clique.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /cliques/1
  # PUT /cliques/1.xml
  def update
    respond_to do |format|
      if @clique.update_attributes(params[:clique])
        flash[:notice] = 'Clique was successfully updated.'
        format.html { redirect_to(@clique) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @clique.errors, :status => :unprocessable_entity }
      end
    end
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
      format.html { redirect_to(cliques_url) }
      format.xml  { head :ok }
    end
  end
  
  private
  def find_clique
    @clique = Clique.find(params[:id])
  end
  
  def permission
    unless @clique.user_id == session[:user_id] or session[:user_id] == User.find_by_name("Storyteller").id
      flash[:notice] = "You don't have permission to do that"
      redirect_to :back
    end
  end
end
