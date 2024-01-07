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
end
