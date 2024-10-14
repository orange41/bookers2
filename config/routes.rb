Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  get '/home/about', to: 'homes#about'
  get '/users', to: 'users#index'
  resources :books, only: [:new, :create, :index, :show, :destroy, :update]
  resources :users, only: [:show, :edit, :update]
end