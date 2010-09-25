class CommentsController < ApplicationController
  layout 'cliques'
  
  def new
    @character = Character.find(params[:character_id])
    @comment = @character.comments.build
  end

  def create
    @character = Character.find(params[:character_id])
    @comment = @character.comments.build(params[:comment])
    if @comment.save
      redirect_to character_path(@character)
    else
      render :action => :new
    end
  end

  def edit
    @character = Character.find(params[:character_id])
    @comment = @character.comments.find(params[:id])
  end

  def update
    @character = Character.find(params[:character_id])
    @comment = Comment.find(params[:id])
    if @comment.update_attributes(params[:comment])
      redirect_to character_path(@character)
    else
      render :action => :edit
    end
  end

  def destroy
    @character = Character.find(params[:character_id])
    @comment = Comment.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to character_path(@character, :notice => 'Comment successfully deleted.') }
      format.xml  { head :ok }
    end
  end
end
