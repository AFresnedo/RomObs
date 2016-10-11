Rails.application.routes.draw do
  # For details on the DSL available within this file, see
  # http://guides.rubyonrails.org/routing.html

  # front page routes
  root 'pages#home'
  get '/home', to: 'pages#home'

  # about page routes
  get '/about', to: 'pages#about'
  get 'about_edit', to: 'pages#about_edit'

  # contact page routes
  get '/contact', to: 'pages#contact'

  # user model pages routes
  get '/edit', to: 'users#edit'
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'

  # logged in pages routes
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  # rails routes to list
  # automatically generated routes for resources
  resources :users
  resources :account_activations, only: [:edit]
  resources :articles, only: [:new, :edit, :create]

end
