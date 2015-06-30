Rails.application.routes.draw do
  resources :users, only: [:show]

  devise_for :users
  root to: 'welcome#index'
end
