# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }
  resources :users

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root to: 'pages#home'
  # Internationalization
  get '/change_locale/:locale', to: 'application#change_locale', as: :change_locale

  resources :articles do
    resources :bids, only: [:create]
  end

  get 'articles/:id/withdraw', to: 'articles#withdraw', as: 'withdraw_article'

  get 'pokemons/index'

  get '/admin', to: 'admin#index'
  get '/admin/users/new', to: 'admin#new_user', as: 'new_admin_user'
  post '/admin/users', to: 'admin#create_user', as: 'admin_users'
  delete '/admin/users/:id', to: 'admin#destroy_user', as: 'destroy_admin_user'
  get '/admin/users/:id', to: 'admin#show_user', as: 'admin_user'

  get '/admin/articles/:id', to: 'admin#show_article', as: 'admin_article'
  delete '/admin/articles/:id', to: 'admin#destroy_article', as: 'destroy_admin_article'
end
