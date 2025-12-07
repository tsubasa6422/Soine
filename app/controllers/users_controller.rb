class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def mypage
    @user = current_user
    @children = @user.children

    if params[:filter] == "timeline"
      # 自分 + フォロー中ユーザーの投稿
      @posts = @user.timeline_posts.includes(:user)
    else
      # 自分の投稿のみ
      @posts = @user.posts.includes(:user)
    end
  end

  def show
  end

  
  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to mypage_path, notice: "ユーザー情報を更新しました。"
    else
      flash.now[:alert] = "更新に失敗しました。"
      render :edit
    end
  end

  def destroy
    @user.destroy
    reset_session
    redirect_to root_path, notice: "退会が完了しました。"
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  
  def ensure_correct_user
    if @user != current_user
      redirect_to root_path, alert: "権限がありません。"
    end
  end

  def user_params
    params.require(:user).permit(:name, :email, :area_id, :other_attr_1, :other_attr_2,:profile_image)
  end

end

