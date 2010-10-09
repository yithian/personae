class CommentsController < ApplicationController
  respond_to :html, :xml
  before_filter :find_character, :only => [:new, :create, :destroy]
  before_filter :find_comment, :only => ["new", "destroy"]
  before_filter :destroy_permission, :only => ["destroy"]

  def new
    respond_with @comment
  end

  def create
    @comment = @character.comments.build(params[:comment])

    if @comment.save
      redirect_to character_path(@character)
    else
      render :action => :new
    end
  end

  def destroy
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to character_path(@character), :notice => 'Comment successfully deleted.' }
      format.xml  { head :ok }
    end
  end

  private
  def find_character
    @character = Character.find_by_id(params[:character_id])
    unless @character.show_name_to_user?(session[:user_id])
      flash[:notice] = "You don't have permission to do that"
      redirect_to :controller => "characters", :action => "index" 
    end
  end

  def find_comment
    if params[:action] == "new"
      @comment = @character.comments.build
    else
      @comment = Comment.find(params[:id])
    end
  end

  def destroy_permission
    unless @comment.can_edit_as_user?(session[:user_id])
      flash[:notice] = "You don't have permission to do that"
      redirect_to character_path(@character)
    end
  end
end
