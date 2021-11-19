Rails.application.routes.draw do

  devise_for :users, controllers: { sessions: 'users/sessions',
    registrations: 'users/registrations'}
    
    devise_scope :user do
      match '/sessions/user', to: 'devise/sessions#create', via: :post
    end

  # devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#index'

  resources :users
  resources :sessions
  resources :carts
  
  namespace :admin do
    root 'sessions#new'
    resources :sessions
    resources :categories
    resources :products
  end
  
  resources :categories, only: [:show]
  resources :products, only: [:show]

end
