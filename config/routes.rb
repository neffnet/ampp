Rails.application.routes.draw do
  devise_for :users
  resources :users, only: []
  resources :sites

  root to: 'welcome#index'
end
