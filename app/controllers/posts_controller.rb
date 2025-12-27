class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authorize_post!, only: [:edit, :update, :destroy]

  def create
    @post = current_user.posts.build(post_params)
    limit_child_ids_to_current_user(@post)

    if @post.save
      redirect_to mypage_path(filter: params[:filter]), notice: "投稿しました。"
    else
      @user = current_user

      if params[:filter] == "timeline"
        @posts = Post.includes(:user, :area, :children, :likes, :comments).order(created_at: :desc)
      else
        @posts = current_user.posts.includes(:area, :children, :likes, :comments).order(created_at: :desc)
      end

      render "users/mypage"
    end
  end

  def show
    @comment  = Comment.new
    @comments = @post.comments.includes(:user).order(created_at: :desc)
  end

  def index
    @q = params[:q].to_s.strip
    @posts = Post.includes(:user, :area, :children, :likes).order(created_at: :desc)

    if @q.present?
      @posts = @posts.where("title LIKE ? OR body LIKE ?", "%#{@q}%", "%#{@q}%")
    end
  end

  def edit
  end

  def update
    @post.assign_attributes(post_params)
    limit_child_ids_to_current_user(@post)

    if @post.save
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
    redirect_to mypage_path(filter: "timeline"), alert: "権限がありません。" unless @post.user == current_user
  end

  def post_params
    params.require(:post).permit(:title, :body, :area_id, images: [], child_ids: [])
  end

  def limit_child_ids_to_current_user(post)
    ids = Array(params.dig(:post, :child_ids)).reject(&:blank?).map(&:to_i)
    post.child_ids = current_user.children.where(id: ids).pluck(:id)
  end
end
