Rails.application.routes.draw do

  devise_for :users
  resources :users, only: []
  
  resources :sites do
    resources :albums, only: [:new, :create, :destroy]
  end

  root to: 'welcome#index'
end
