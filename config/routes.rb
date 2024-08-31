Rails.application.routes.draw do
  get 'users/index'
  resources :swipes, only: [:create]
  resources :matches, only: [:index]
  resources :users, only: [:index]
  root 'home#index'
  resource :profile, only: [:show, :edit, :update]
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html


  # Defines the root path route ("/")
  # root "articles#index"
end
