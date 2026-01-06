class Admin::UsersController < Admin::BaseController
  def index
    @users = User.order(created_at: :desc)
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order(created_at: :desc)
  end

  def destroy
    user = User.find(params[:id])
    user.destroy!
    redirect_to admin_users_path, notice: "User deleted."
  rescue => e
    redirect_to admin_user_path(user), alert: "削除に失敗しました: #{e.class}"
  end
end
