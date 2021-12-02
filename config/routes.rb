Rails.application.routes.draw do
  devise_for :moderators
  root to: 'home#index'
  devise_for :users

  namespace :admin do
    get '/', to: 'home#index'
    resources :users
    resources :moderators
  end
end
