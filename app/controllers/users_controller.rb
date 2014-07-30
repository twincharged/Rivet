class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, except: [:new, :create, :show, :index]



  def new
    @user = User.new
  end



  def create
    @user = User.new(signup_params)
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to Bicycle!"
      redirect_to @user
    else
      render :new
    end
  end



  def index
    @posts = @user.posts.paginate(page: params[:page])
  end



  def show
  end



  def edit
    if request.xhr? && @user.update_attributes(user_edit_params)
      redirect_to :back
    else
      render :edit
    end
  end



  def update
    @user.update_attributes(user_edit_params)
    @user.save!
  end



  def destroy
    current_user.destroy
    flash[:success] = "User destroyed."
    redirect_to root_path
  end



  def following
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page])
    render 'show_follow'
  end



  def followers
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end





  private


    def set_user
      @user = User.find(params[:id])
    end



    def signup_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
    end


    def user_edit_params
      params.require(:user).permit(:avatar, :avatar_cache, :backdrop, :first_name, :last_name, :description, :birthday, :gender, :password, :password_confirmation) 
    end
end
