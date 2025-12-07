Rails.application.routes.draw do
  devise_for :users

  root to: 'homes#top'
  get '/about', to: 'homes#about'

  # マイページ
  get '/mypage', to: 'users#mypage', as: :mypage

  # ユーザーCRUD
  resources :users, only: [:show, :edit, :update, :destroy]

  
  resources :children, only: [:new, :create, :edit, :update, :destroy]

  resources :posts do
    resources :comments, only: [:create, :destroy]
    resource  :like, only: [:create, :destroy]
    resources :child_posts, only: [:create, :destroy]
  end
end
