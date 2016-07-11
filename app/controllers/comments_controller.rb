# Controller for comment actions: create/edit/destroy

class CommentsController < ApplicationController
  respond_to :html, :xml
  load_and_authorize_resource

  before_action :find_character, :only => [:new, :create, :destroy]
  before_action :find_comment, :only => ["new", "destroy"]

  # GET /characters/comments/new
  # GET /characters/comments/new.xml
  def new
    respond_with @comment
  end

  # POST /characters/comments
  # POST /characters/comments
  def create
    @comment = @character.comments.build(comment_params)

    if @comment.save
      redirect_to chronicle_character_path(@character.chronicle, @character)
    else
      render :action => :new
    end
  end

  # DELETE /characters/comments/1
  # DELETE /characters/comments/1.xml
  def destroy
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to chronicle_character_path(@character.chronicle, @character), :notice => 'Comment successfully deleted.' }
      format.xml  { head :ok }
    end
  end

  private
  # Sets up a character variable and allows or denies access to
  # comment on it
  def find_character
    @character = Character.find_by_id(params[:character_id])
    unless can? :read, @character
      flash[:notice] = "You don't have permission to do that"
      redirect_to chronicle_characters_path(@character.chronicle)
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

  # generate strong parameters
  def comment_params
    params.require(:comment).permit(:character_id, :user_id, :speaker, :body)
  end
end
