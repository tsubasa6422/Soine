# app/controllers/reports_controller.rb
class ReportsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post

  def new
    @report = @post.reports.build
  end

  def create
    @report = @post.reports.build(report_params)
    @report.reporter = current_user

    if @report.save
      redirect_to @post, notice: "通報を受け付けました。ご協力ありがとうございます。"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def report_params
    params.require(:report).permit(:reason, :detail)
  end
end