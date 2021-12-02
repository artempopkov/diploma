Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'

  namespace :admin do
    get 'home/index'
    resource :users
  end
end
