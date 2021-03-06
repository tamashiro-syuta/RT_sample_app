Rails.application.routes.draw do
  
  get 'password_resets/new'
  get 'password_resets/edit'
  root 'static_pages#home'
  
  # 名前付きルートの設定
  get  '/help',    to: 'static_pages#help'
  get  '/about',   to: 'static_pages#about'
  get  '/contact', to: 'static_pages#contact'
  
  # デフォルトの　users_new_url　を　signup_path　に修正
  get '/signup', to: 'users#new'
  
  # /users/1 のURLを有効にするため
  resources :users
  
  # AccountActivationsを名前付きルートで扱えるように
  resources :account_activations, only: [:edit]
  
  # パスワードの再設定用
  resources :password_resets,     only: [:new, :create, :edit, :update]
  
  resources :microposts,          only: [:create, :destroy]
  
  resources :relationships,       only: [:create, :destroy]
  
  # ログイン時のセッション用
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  
  # フォロー機能
  # /users/1/following や /users/1/followers のようになる
  resources :users do
    member do
      get :following, :followers
    end
  end
  
end
