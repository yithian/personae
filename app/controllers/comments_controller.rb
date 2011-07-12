# Controller for comment actions: create/edit/destroy

class CommentsController < ApplicationController
  respond_to :html, :xml
  load_and_authorize_resource
  before_filter :find_character, :only => [:new, :create, :destroy]
  before_filter :find_comment, :only => ["new", "destroy"]

  # GET /characters/comments/new
  # GET /characters/comments/new.xml
  def new
    respond_with @comment
  end

  # POST /characters/comments
  # POST /characters/comments
  def create
    @comment = @character.comments.build(params[:comment])

    if @comment.save
      redirect_to character_path(@character)
    else
      render :action => :new
    end
  end

  # DELETE /characters/comments/1
  # DELETE /characters/comments/1.xml
  def destroy
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to character_path(@character), :notice => 'Comment successfully deleted.' }
      format.xml  { head :ok }
    end
  end

  private
  # Sets up a character variable and allows or denies access to
  # comment on it based on Character#show_name_to_user?
  def find_character
    @character = Character.find_by_id(params[:character_id])
    unless @character.show_name_to_user?(current_user)
      flash[:notice] = "You don't have permission to do that"
      redirect_to :controller => "characters", :action => "index" 
    end
  end

  # Sets up a comment object based on an id passed by url or
  # creates a new (empty) comment.
  def find_comment
    if params[:action] == "new"
      @comment = @character.comments.build
    else
      @comment = Comment.find(params[:id])
    end
  end
end
