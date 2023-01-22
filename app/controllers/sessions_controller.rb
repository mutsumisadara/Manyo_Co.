class SessionsController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]
  
  def new
  end

  def create # 送られてきたemailを元にfindbyでDBからuserを取り出す。authenticateでemailとpassword正しいかみてる
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id # sessionsメソッドでログイン、cookiesに暗号化されたユーザーIDが自動で生成される
      redirect_to user_path(user.id)
    else
      flash[:notice] = 'ログインに失敗しました'
      render :new
    end
  end

  def destroy
    session.delete(:user_id)
    flash[:notice] = 'ログアウトしました'
    redirect_to new_session_path
  end
end
