Rails.application.routes.draw do
  devise_for :users

  root to: 'products#last_sales'

  resources :payments, only: :index
  resources :clients
  resources :products
  resources :reports, only: :index

  get '/add_attributes', as: 'attributes', to: 'products#attributes'
  post '/add_attributes', as: 'add_attributes', to: 'products#add_attributes'
  post '/delete_attribute', as: 'delete_attribute', to: 'products#delete_attribute'

  post '/pay_product', as: 'pay_product', to: 'products#pay_product'

  get '/last_sales', to: 'products#last_sales'
end
