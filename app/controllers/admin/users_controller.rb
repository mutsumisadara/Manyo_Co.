class Admin::UsersController < ApplicationController
    def index
        @user = User.all
        # @tasks = Task.all
    end

    def show
        @user = User.find(params[:id])
        @tasks = Task.find(params[:id])
    end

    def edit
        @user = User.find(params[:id])
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
        redirect_to admin_users_path(user.id), notice: "タスクを削除しました！"
      end
    end

    # private
    
    # def user_params
    #   params.require(:user).permit(:name, :email, :password, :password_confirmation)
    # end
end