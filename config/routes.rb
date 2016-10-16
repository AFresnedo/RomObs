Rails.application.routes.draw do
  # For details on the DSL available within this file, see
  # http://guides.rubyonrails.org/routing.html

  # front page routes
  root 'pages#home'
  get '/home', to: 'pages#home'
  get '/home/edit', to: 'pages#home_edit'

  # about page routes
  get '/about', to: 'pages#about'
  get 'about/edit', to: 'pages#about_edit'

  # contact page routes
  get '/contact', to: 'pages#contact'
  get 'contact/edit', to: 'pages#contact_edit'

  # user model pages routes
  get '/edit', to: 'users#edit'
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'

  # login pages routes
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  # rails routes to list
  # automatically generated routes for resources
  resources :users
  resources :account_activations, only: [:edit]
  resources :articles, only: [:new, :edit, :create, :update]

end
