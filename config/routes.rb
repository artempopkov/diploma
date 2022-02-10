Rails.application.routes.draw do
  root to: "home#index"

  devise_for :moderators
  devise_for :users

  namespace :admin do
    get "/", to: "home#index"
    resources :users
    resources :moderators
    resources :categories
    resources :articles do
      resources :article_reviews, only: [:new, :create], as: :reviews
      member do
        patch "prepare", to: "articles#prepare"
      end
      # patch 'publish', to: 'article_reviews#publish_article', as: 'publish_article'
    end

    get "tags/:tag", to: "articles#tag", as: :tag
  end
end
