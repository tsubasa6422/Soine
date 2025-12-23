class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authorize_post!, only: [:edit, :update, :destroy]

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to mypage_path(filter: params[:filter]), notice: "投稿しました。"
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

  def show
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to post_path(@post), notice: "投稿を更新しました。"
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to mypage_path, notice: "投稿を削除しました。"
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def authorize_post!
    redirect_to post_path(@post), alert: "権限がありません。" unless @post.user == current_user
  end

  def post_params
    params.require(:post).permit(:title, :body, :area_id, child_ids: [])
  end
end
