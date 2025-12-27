class ChildrenController < ApplicationController
  before_action :authenticate_user!
  before_action :set_child, only: [:edit, :update, :destroy]

  def index
    @children = current_user.children.order(created_at: :desc)
  end

  def new
    @child = current_user.children.build
  end

  def create
    @child = current_user.children.build(child_params)
    if @child.save
      redirect_to children_path, notice: "子ども情報を登録しました。"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @child.update(child_params)
      redirect_to children_path, notice: "子ども情報を更新しました。"
    else
      render :edit
    end
  end

  def destroy
    @child.destroy
    redirect_to children_path, notice: "子ども情報を削除しました。"
  end

  private

  def set_child
    @child = current_user.children.find(params[:id])
  end

def child_params
  params.require(:child).permit(:name, :age, :age_months, :gender, :image)
end



end
