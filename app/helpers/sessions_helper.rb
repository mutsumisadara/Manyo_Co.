module SessionsHelper
    def current_user
      @current_user ||= User.find_by(id: session[:user_id]) # 偽か未定義なら右辺を左辺へ自己代入
    end

    def logged_in?
      current_user.present?
    end
end
