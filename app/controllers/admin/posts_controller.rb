class Admin::PostsController < Admin::BaseController
  def index
    @posts = Post.includes(:user, :area).order(created_at: :desc)
  end

  def show
    @post = Post.includes(:user, :area, :comments).find(params[:id])
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy!
    redirect_to admin_posts_path, notice: "Post deleted."
  rescue => e
    redirect_to admin_post_path(post), alert: "削除に失敗しました: #{e.class}"
  end
end
