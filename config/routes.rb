Rails.application.routes.draw do
  root to: 'home#index'

  devise_for :moderators
  devise_for :users

  namespace :admin do
    get '/', to: 'home#index'
    resources :users
    resources :moderators
    resources :categories
    resources :articles
    patch 'send_for_review/:id', to: 'articles#send_for_review', as: 'send_for_review'
    get 'tags/:tag', to: 'articles#tag', as: :tag
  end
end
