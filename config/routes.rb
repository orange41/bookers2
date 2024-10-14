Rails.application.routes.draw do
  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout' }
  root to: 'homes#top'
  get '/home/about', to: 'homes#about'
  get '/users', to: 'users#index'
  resources :books, only: [:new, :create, :index, :show, :destroy, :update]
  resources :users, only: [:show, :edit, :update]
  
end