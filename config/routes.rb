Rails.application.routes.draw do
  devise_for :users

  root to: 'payments#index'

  resources :payments, only: :index
  resources :clients
  resources :products

  get '/add_attributes', as: 'attributes', to: 'products#attributes'
  post '/add_attributes', as: 'add_attributes', to: 'products#add_attributes'
end
