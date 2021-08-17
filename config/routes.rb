Rails.application.routes.draw do
  
  root 'static_pages#home'
  
  # 名前付きルートの設定
  get  '/help',    to: 'static_pages#help'
  get  '/about',   to: 'static_pages#about'
  get  '/contact', to: 'static_pages#contact'
  
  # デフォルトの　users_new_url　を　signup_path　に修正
  get '/signup', to: 'users#new'
end
