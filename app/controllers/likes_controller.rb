class LikesController < ApplicationController
  before_action :set_like, only: :destroy
  before_filter :require_user!
  before_filter :authenticate_user!


  def new
    @like = Like.new
  end


  def create
    @like = Like.new
    @like.user_id = current_user.id
    @like.likeable = params[:likeable]
    @like.save!
    @like_count = @like.likeable.likes.size
  end


  def index
    @like = Like.where(likeable: params[:likeable])
  end


  def destroy
    if @like.destroy && request.xhr?
      render partial: "likes/show"
    else
      redirect_to :back
    end 
  end


  private


    def set_like
      @like = Like.find(params[:id])
    end


    def like_params
      params.require(:like).permit(:user_id, :likeable)
    end
end
