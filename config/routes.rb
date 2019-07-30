Rails.application.routes.draw do
  devise_for :users

  root to: 'products#last_sales'

  resources :payments, only: :index
  resources :clients
  resources :products
  resources :reports
  resources :users, only: [:edit, :update]

  post '/products/:id/return', as: 'product_return', to: 'products#return'

  post '/pay_product', as: 'pay_product', to: 'products#pay_product'

  get '/last_sales', to: 'products#last_sales'
end
