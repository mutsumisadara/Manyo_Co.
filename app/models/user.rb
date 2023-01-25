class User < ApplicationRecord
  before_destroy :admin_must_exist
  has_many :tasks, dependent: :destroy
  validates :name, presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 }, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  before_validation { email.downcase! }
  has_secure_password # パスワードをハッシュ化し、DB内password_digestに保存してくれるので簡単安心。
  validates :password, length: { minimum: 5 }
  enum admin: { 一般ユーザー: false, 管理者: true}


  private
  def admin_must_exist
    admin_user = User.where(admin: true)
    if self.admin? && admin_user == 1
    # if User.where(admin: true).count == 1
    # if admin? == 1 削除される
    # if User.admins.count == 1　削除される
    # if User.exists?(admin: true) && self.admin == true 削除される
    # if User.admins.empty? 削除される
      throw(:abort)
      redirect_to admin_users_path, notice: 'あなたが最後の管理者です'
      # render :index
      flash.now[:notice] = 'あなたが最後の管理者です'
    end
  end
end
