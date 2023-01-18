class User < ApplicationRecord
  has_many :tasks
  validates :name, presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 }, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  before_validation { email.downcase! }
  has_secure_password # パスワードをハッシュ化し、DB内password_digestに保存してくれるので簡単安心。
  validates :password, length: { minimum: 5 }
end
