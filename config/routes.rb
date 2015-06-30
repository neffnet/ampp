Rails.application.routes.draw do
  devise_for :users
  resources :users, only: []

  root to: 'welcome#index'
end
