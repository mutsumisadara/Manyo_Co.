class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    include SessionsHelper # applicationcontrollerに書くことで全コントローラーでこのモジュール使える
    before_action :login_required # どのアクション起こすまえにloginrequireする

    private

    def login_required
      redirect_to new_session_path unless current_user
    end
end