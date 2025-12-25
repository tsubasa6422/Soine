Rails.application.routes.draw do
  devise_for :users

  root to: 'homes#top'
  get '/about', to: 'homes#about'

  get '/mypage', to: 'users#mypage', as: :mypage
  resources :users, only: [:show, :edit, :update, :destroy]

  get 'timeline', to: 'timeline#index', as: :timeline

  resources :children, only: [:new, :create, :edit, :update, :destroy]

  resources :posts do
    resources :comments, only: [:create, :destroy]
    resource  :like, only: [:create, :destroy]
    resources :child_posts, only: [:create, :destroy]
  end

    get "/search", to: "search#posts"
    get "/search/users", to: "search#users", as: :search_users


end
