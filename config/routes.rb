Rails.application.routes.draw do
  root to: 'home#index'

  namespace :admin do
    get 'home/index'
  end
end
