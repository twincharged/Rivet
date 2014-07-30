class RelationshipsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :followed_params

  def create
    @user = User.find(params[:id])
    current_user.follow!(@user)
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow!(@user)
  end

  private

  def followed_params
    params.require(:relationship).permit(:followed_id, :follower_id, :accepted) if params[:relationship]
  end
end
