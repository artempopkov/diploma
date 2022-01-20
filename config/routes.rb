Rails.application.routes.draw do
  root to: 'home#index'

  devise_for :moderators
  devise_for :users
  resources :articles , only: [:show]

  namespace :admin do
    get '/', to: 'home#index'
    resources :users
    resources :moderators
    resources :categories
    resources :articles
    resources :reviews
    patch 'send_for_review/:id', to: 'articles#send_for_review', as: 'send_for_review'
    patch 'publish/:id', to: 'articles#publish', as: 'publish'
    patch 'remove_avatar/:id', to: 'articles#remove_avatar', as: 'remove_avatar'
    put 'mark_as_important/:id', to: 'articles#mark_as_important', as: 'mark_as_important'
    get 'tags/:tag', to: 'articles#tag', as: :tag
  end
end
