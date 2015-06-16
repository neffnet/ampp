Rails.application.routes.draw do

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  resources :users, only: [:show]
  resources :sites, only: [:show]
  
  get 'welcome/index'
  root to: 'welcome#index'
end
