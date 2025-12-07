class HomesController < ApplicationController
  def top
    # ログイン済みならマイページへ
    if user_signed_in?
      redirect_to mypage_path
    end
  end

  def about
  end
end
