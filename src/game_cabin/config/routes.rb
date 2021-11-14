Rails.application.routes.draw do

  devise_for :users, controllers: { regisrations: "users/regisrations" }  

  # devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#index'
  resources :users
  resources :sessions
  
  namespace :admin do
    root 'sessions#new'
    resources :sessions
    resources :categories
  end
  

end
