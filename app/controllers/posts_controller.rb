class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authorize_post!, only: [:edit, :update, :destroy]

  def create
    @post = current_user.posts.build(post_params)

    child_ids = selected_child_ids

    if @post.save
      child_ids.each do |cid|
        @post.child_posts.create!(child_id: cid)
      end
      redirect_to mypage_path(filter: params[:filter]), notice: "投稿しました。"
    else
      render :new
    end
  end

  def show
    @comment = Comment.new
    @comments = @post.comments
                     .where(parent_id: nil)
                     .includes(:user, replies: :user)
                     .order(created_at: :desc)
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

    child_ids = selected_child_ids

    if @post.save
      @post.child_posts.destroy_all
      child_ids.each do |cid|
        @post.child_posts.create!(child_id: cid)
      end
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
    return if @post.user == current_user
    redirect_to mypage_path(filter: "timeline"), alert: "権限がありません。"
  end

  def post_params
    params.require(:post).permit(:title, :body, :area_id, images: [], child_ids: [])
  end

  def selected_child_ids
    ids = Array(params.dig(:post, :child_ids)).reject(&:blank?).map(&:to_i)
    current_user.children.where(id: ids).pluck(:id)
  end
end
