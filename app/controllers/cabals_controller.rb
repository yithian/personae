class CabalsController < ApplicationController
  before_filter :find_cabal, :only => [:show, :edit, :update, :destroy]
  # GET /cabals
  # GET /cabals.xml
  def index
    @cabals = Cabal.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @cabals }
    end
  end

  # GET /cabals/1
  # GET /cabals/1.xml
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @cabal }
    end
  end

  # GET /cabals/new
  # GET /cabals/new.xml
  def new
    @cabal = Cabal.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @cabal }
    end
  end

  # GET /cabals/1/edit
  def edit
  end

  # POST /cabals
  # POST /cabals.xml
  def create
    @cabal = Cabal.new(params[:cabal])

    respond_to do |format|
      if @cabal.save
        flash[:notice] = 'Cabal was successfully created.'
        format.html { redirect_to(@cabal) }
        format.xml  { render :xml => @cabal, :status => :created, :location => @cabal }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @cabal.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /cabals/1
  # PUT /cabals/1.xml
  def update
    respond_to do |format|
      if @cabal.update_attributes(params[:cabal])
        flash[:notice] = 'Cabal was successfully updated.'
        format.html { redirect_to(@cabal) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @cabal.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /cabals/1
  # DELETE /cabals/1.xml
  def destroy
    if @cabal != Cabal.find_by_name('Solitary')
      @cabal.characters.each do |m|
        m.cabal_id = Cabal.find_by_name('Solitary').id
        m.save
      end
      
      @cabal.destroy
    else
      flash[:notice] = 'Solitaries are not a cabal, dummy.'
    end

    respond_to do |format|
      format.html { redirect_to(cabals_url) }
      format.xml  { head :ok }
    end
  end
  
  private
  def find_cabal
    @cabal = Cabal.find(params[:id])
  end
end
