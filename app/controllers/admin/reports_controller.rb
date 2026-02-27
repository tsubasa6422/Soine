class Admin::ReportsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_report, only: [:show, :update]

  def index
    @reports = Report.includes(:post, :reporter).order(created_at: :desc)
    @reports = @reports.where(status: params[:status]) if params[:status].present?
  end

  def show
  end

  def update
    if @report.update(admin_report_params)
      if params[:hide_post] == "1"
        @report.post.update!(is_hidden: true)
      end
      redirect_to admin_report_path(@report), notice: "更新しました"
    else
      render :show, status: :unprocessable_entity
    end
  end

  private

  def set_report
    @report = Report.find(params[:id])
  end

  def admin_report_params
    params.require(:report).permit(:status)
  end
end