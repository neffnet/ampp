Rails.application.routes.draw do

  devise_for :users
  resources :users, only: []
  
  resources :sites do
    resources :albums, only: [:new, :create, :destroy]
  end

  post '/get_album/:id', to: 'sites#get_album'

  root to: 'welcome#index'

  # use with friendly_id
  get '/:id' => 'sites#show'
  patch '/:id' => 'sites#update'

end

