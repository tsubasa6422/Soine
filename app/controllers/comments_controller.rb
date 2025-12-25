class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post

  def create
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to post_path(@post), notice: "コメントしました。"
    else
      @comments = @post.comments.includes(:user).order(created_at: :desc)
      render "posts/show", status: :unprocessable_entity
    end
  end

  def destroy
    @comment = @post.comments.find(params[:id])

    unless @comment.user == current_user
      return redirect_to post_path(@post), alert: "削除権限がありません。"
    end

    @comment.destroy
    redirect_to post_path(@post), notice: "コメントを削除しました。"
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:comment)
  end

end
