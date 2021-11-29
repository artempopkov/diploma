Rails.application.routes.draw do
  root to: 'home#index'

  namespace :admin do
    get 'panel/index'
  end
end
