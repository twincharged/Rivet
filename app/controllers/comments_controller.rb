class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!

  def new
    @comment = Comment.new
  end

  

  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    @comment.threadable = params[:threadable]
    @comment.save!
  end



  def index
    @comment = Comment.where(threadable: params[:threadable])
  end



  def show
    render :show
  end



  def edit
    if request.xhr? && @comment.update_attributes(comment_edit_params)
      redirect_to :back
    else
      render :edit
    end
  end



  def update
    @comment.update_attributes(comment_edit_params)
    @comment.save!
  end



  def destroy
    if request.xhr? && @comment.destroy
      render partial: :show
    else
      redirect_to :back
    end
  end



  private



    def set_comment
      @comment = Comment.find(params[:id])
    end



    def comment_params
      params.require(:comment).permit(:body, :threadable, :user_id) if params[:comment]
    end



    def comment_edit_params
      params.require(:comment).permit(:body) if params[:comment]
    end
end
