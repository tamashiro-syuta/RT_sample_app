Rails.application.routes.draw do
  
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
  
  # ログイン時のセッション用
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
end
