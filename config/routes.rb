Rails.application.routes.draw do
  root to: 'home#index'

  devise_for :moderators
  devise_for :users
  resources :articles

  namespace :admin do
    get '/', to: 'home#index'
    resources :users
    resources :moderators
  end
end
