class PostsController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = current_user.posts.build(post_params)
    
    #@post.area = current_user.area

    if @post.save
      redirect_to mypage_path, notice: "投稿しました。"
    else
      
      @user = current_user

      if params[:filter] == "timeline"
        @posts = Post.includes(:user, :area).order(created_at: :desc)
      else
        @posts = current_user.posts.includes(:area).order(created_at: :desc)
      end

      render "users/mypage"
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
