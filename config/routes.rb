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
  end
end
