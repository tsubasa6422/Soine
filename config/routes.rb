Rails.application.routes.draw do
  devise_for :users
  devise_for :admins, path: "admin"

  namespace :admin do
    root to: "dashboard#index"
    resources :users, only: [:index, :show, :destroy]
    resources :posts, only: [:index, :show, :destroy]
  end

  root to: "homes#top"
  get "/about", to: "homes#about"

  get "/mypage", to: "users#mypage", as: :mypage

  resources :users, only: [:show, :edit, :update, :destroy] do
    get :likes, on: :member
  end

  get "timeline", to: "timeline#index", as: :timeline

  resources :children, only: [:index, :new, :create, :edit, :update, :destroy] do
    get :posts, on: :member
  end

  resources :posts do
    resources :comments, only: [:create, :destroy]
    resource :like, only: [:create, :destroy]
    resources :child_posts, only: [:create, :destroy]
  end

  get "/search", to: "search#posts"
  get "/search/users", to: "search#users", as: :search_users
end

