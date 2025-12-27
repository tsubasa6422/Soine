class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authorize_post!, only: [:edit, :update, :destroy]

  def create
    @post = current_user.posts.build(post_params)

    ids = Array(params.dig(:post, :child_ids)).reject(&:blank?).map(&:to_i).uniq
    children = current_user.children.where(id: ids)

    ActiveRecord::Base.transaction do
      @post.save!

      children.each do |child|
        @post.child_posts.find_or_create_by!(child_id: child.id) do |cp|
          cp.child_name = child.name
          cp.child_age_months = child.age_months
          cp.child_gender = child.gender_before_type_cast
        end
      end
    end

    redirect_to mypage_path(filter: params[:filter]), notice: "投稿しました。"
  rescue ActiveRecord::RecordInvalid => e
    Rails.logger.error(e.message)
    flash.now[:alert] = "投稿に失敗しました：#{e.record.errors.full_messages.join(', ')}"
    render "users/mypage"
  end

  def update
    @post.assign_attributes(post_params)

    ids = Array(params.dig(:post, :child_ids)).reject(&:blank?).map(&:to_i).uniq
    children = current_user.children.where(id: ids)

    ActiveRecord::Base.transaction do
      @post.save!
      @post.child_posts.destroy_all
      children.each do |child|
        @post.child_posts.create!(
          child_id: child.id,
          child_name: child.name,
          child_age_months: child.age_months,
          child_gender: child.gender_before_type_cast
        )
      end
    end

    redirect_to post_path(@post), notice: "投稿を更新しました。"
  rescue ActiveRecord::RecordInvalid => e
    flash.now[:alert] = e.record.errors.full_messages.join(", ")
    render :edit
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
    @posts = @posts.where("title LIKE ? OR body LIKE ?", "%#{@q}%", "%#{@q}%") if @q.present?
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
    params.require(:post).permit(:title, :body, :area_id, images: [])
  end

end
