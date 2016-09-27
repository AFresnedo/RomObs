Rails.application.routes.draw do
  root 'static_pages#home'

  get '/about', to: 'static_pages#about'

  # For details on the DSL available within this file, see
  # http://guides.rubyonrails.org/routing.html

  get '/edit', to: 'users#edit'
  # rails routes to list
  resources :users

end
