class CommentsController < ApplicationController
  before_filter :find_character, :only => [:new, :create, :edit, :update, :destroy]

  def new
    @comment = @character.comments.build
  end

  def create
    @comment = @character.comments.build(params[:comment])

    if @comment.save
      redirect_to character_path(@character)
    else
      render :action => :new
    end
  end

  def edit
    @comment = @character.comments.find(params[:id])
    edit_permission
  end

  def update
    @comment = Comment.find(params[:id])
    edit_permission

    if @comment.update_attributes(params[:comment])
      redirect_to character_path(@character)
    else
      render :action => :edit
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    edit_permission
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to character_path(@character, :notice => 'Comment successfully deleted.') }
      format.xml  { head :ok }
    end
  end

  private
  def find_character
    @character = Character.find_by_id(params[:character_id])
    unless show_character?(@character)
      flash[:notice] = "You don't have permission to do that"
      redirect_to :controller => "characters", :action => "index" 
    end
  end

  def edit_permission
    unless @comment.can_edit_as_user?(session[:user_id])
      flash[:notice] = "You don't have permission to do that"
      redirect_to :controller => "characters", :action => "index"
    end
  end
end
