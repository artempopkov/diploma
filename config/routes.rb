Rails.application.routes.draw do
  require 'sidekiq/web'
  require 'sidekiq/cron/web'

  devise_scope :moderator do
    authenticate :moderator, ->(moderator) { moderator.admin? } do
      mount Sidekiq::Web => '/admin/sidekiq'
    end
  end

  match '/404', to: 'errors#not_found', via: :all
  match '/500', to: 'errors#internal_server_error', via: :all
  
  root to: "home#index"
  get '/users/', to: 'home#index'
  devise_for :moderators
  devise_for :users, controllers: { registrations: "users/registrations" }

  resources :users do
    resources :email_subscriptions, except: [:new, :create, :destroy]
    member do
      get "likes_history", to: "user_histories#likes"
      get "views_history", to: "user_histories#views"
      get "comments_history", to: "user_histories#comments"
    end
  end

  resources :articles, only: [:show], constraints: ShowArticlesConstraint.new do
    resources :comments
    member do
      put "like", to: "articles#like"
    end
  end

  match "search" => "home#search", via: [:get, :post], as: :search

  namespace :admin do
    get "/", to: "home#index"
    get "users_report", to: "reports#users_report"
    get "correspondents_report", to: "reports#correspondents_report"
    get "articles_report", to: "reports#articles_report"
    resources :users
    resources :moderators
    resources :categories
    resources :comments, only: [:index, :destroy]

    resources :articles do
      resources :article_reviews, only: [:new, :create], as: :reviews
      member do
        patch "prepare", to: "articles#prepare"
        patch "publish", to: "articles#publish"
        patch "toggle_important", to: "articles#toggle_important"
        patch "remove_avatar", to: "articles#remove_avatar"
      end
    end
    get "tags/:tag", to: "articles#tag", as: :tag
  end
end
