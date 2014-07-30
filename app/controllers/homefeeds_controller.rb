class HomefeedsController < ApplicationController
	before_filter :authenticate_user!



  def index_follow_posts
      @post  = current_user.posts.build(post_params)
      @feed_items = current_user.follow_feed #.paginate(page: params[:page])
  end



  def index
      @post  = current_user.posts.build(post_params)

  end



  private

    def post_params
      params.require(:post).permit(:body, :user_id) if params[:post]
    end

end
