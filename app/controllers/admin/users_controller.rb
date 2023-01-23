class Admin::UsersController < ApplicationController

  def index
    if @current_user.admin == "管理者"
      # @current_user.admin?
      @user = User.select(:id, :name, :email, :password_digest, :created_at, :updated_at, :admin)
      @tasks = Task.select(:id, :title, :to_do, :created_at, :updated_at, :deadline, :status, :priority, :user_id)
      # @user = User.all.includes(:user)
      # @tasks = Task.all
    else
      redirect_to tasks_path, notice: 'アクセス権限がありません'
    end
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    # @tasks = Task.find(params[:id])要らない
  end
  
  def edit
    @user = User.find(params[:id])
    # @tasks = Task.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_users_path, notice: "ユーザーを更新しました！"
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      redirect_to admin_users_path
      flash[:notice] = "ユーザーを削除しました！"
    end
  end

  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
  end
end