Rails.application.routes.draw do
  # For details on the DSL available within this file, see
  # http://guides.rubyonrails.org/routing.html

  root 'pages#home'

  get '/about', to: 'pages#about'

  get '/edit', to: 'users#edit'
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  # rails routes to list
  resources :users
  resources :account_activations, only: [:edit]
  resources :articles, only: [:new, :edit, :create]

end
