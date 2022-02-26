Rails.application.routes.draw do
  root to: "home#index"

  devise_for :moderators
  devise_for :users

  resources :articles , only: [:show] do
    resources :comments
    member do
      put 'like', to: 'articles#like'
    end
    collection do
      match 'search' => 'home#search', via: [:get, :post], as: :search
    end
  end

  namespace :admin do
    get "/", to: "home#index"
    resources :users
    resources :moderators
    resources :categories

    resources :articles do
      resources :article_reviews, only: [:new, :create], as: :reviews
      member do
        patch 'prepare', to: 'articles#prepare'
        patch 'publish', to: 'articles#publish'
        patch 'toggle_important', to: 'articles#toggle_important'
        patch 'remove_avatar', to: 'articles#remove_avatar'
      end
    end
    get "tags/:tag", to: "articles#tag", as: :tag
  end
end
