class SearchController < ApplicationController
  before_action :authenticate_user!

  def posts
    @q = params[:q].to_s.strip
    @sort = params[:sort].to_s
    @area_id = params[:area_id].to_s

    @posts = Post.includes(
      :area,
      :likes,
      :comments,
      user: { profile_image_attachment: :blob }
    )

    @posts = @posts.where("title LIKE :q OR body LIKE :q", q: "%#{@q}%") if @q.present?
    @posts = @posts.where(area_id: @area_id) if @area_id.present?

    @posts =
      case @sort
      when "old" then @posts.order(created_at: :asc)
      else @posts.order(created_at: :desc)
      end
  end


  def users
    @q = params[:q].to_s.strip
    @sort = params[:sort].to_s

    @users = User.all

    if @q.present?
      # name で検索（必要なら email も追加OK）
      @users = @users.where("name LIKE ?", "%#{@q}%")
    end

    @users =
      case @sort
      when "old" then @users.order(created_at: :asc)
      else @users.order(created_at: :desc)
      end
  end
end
