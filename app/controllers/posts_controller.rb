class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_filter :correct_user, only: [:destroy, :update, :edit]
  before_filter :authenticate_user!



  def new
    @post = Post.new
  end



  def create
    @post = Post.create(post_params)
    @post.user_id = current_user.id
    if request.xhr? && @post.save
        render partial: :show, locals: {post: @post}
    else
        flash[:errors] = @post.errors.full_messages
    end
      redirect_to root_path
  end



  def index
    @user = User.find(params[:id])
    @post = Post.where(user_id: @user)
  end



  def show
    render :show
  end



  def edit
    if request.xhr? && @post.update_attributes(post_edit_params)
      redirect_to :back
    else
      render :edit
    end
  end



  def update
    @post.update_attributes(post_edit_params)
    @post.save!
  end



  def destroy
    if request.xhr? && @post.destroy
      render partial: :show
    else
      redirect_to :back
    end
  end



  private



    def set_post
      @post = Post.find(params[:id])
    end



    def post_params
      params.require(:post).permit(:body, :public, :user_id, :photo) if params[:post]
    end



    def post_edit_params
      params.require(:post).permit(:body, :public) if params[:post]
    end
end
