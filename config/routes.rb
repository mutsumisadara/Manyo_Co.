Rails.application.routes.draw do
  # root to: 'tasks#index'
  resources :sessions, only: [:new, :create, :show, :destroy]
  resources :users, only: [:new, :create, :show] # 追加でrails routes確認
  resources :tasks
end