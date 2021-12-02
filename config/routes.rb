Rails.application.routes.draw do
  root to: 'home#index'
  devise_for :users

  namespace :admin do
    get '/', to: 'home#index'
    resources :users
  end
end
