Rails.application.routes.draw do
  get 'sessions/new'
  root to: 'tasks#index'
  resources :tasks
  resources :users, only: [:new, :create, :show] # 追加でrails routes確認
end