class UsersController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]

  def new
    @user = User.new # user modelの新しいインスタンス作成。
  end

  def create
    @user = User.new(user_params) # privateのメソッドでuser情報をインスタンスへ保存。
    if @user.save
      session[:user_id] = @user.id # 一時cookiesに暗号化済みのユーザーIDでuser登録の後そのままログイン
      redirect_to user_path(@user.id) # showアクションに送られるからroutesで見て引数にuserid必要 # 正しく保存されたらtaskマイページへ
    else
      render :new # それ以外は作成ページへ舞い戻る
    end
  end

  def show
    @user = User.find(params[:id]) # useridがストパラで送られてくる表示するuseridを取得
    # @task = Task.find(params[:id])
    # binding.irb
    # @task = @current_user.tasks.order(created_at: "DESC").page(params[:page])
    # redirect_to tasks_path
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
