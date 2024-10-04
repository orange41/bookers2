Rails.application.routes.draw do
  root 'homes#top'
  devise_for :users
  post '/books', to: 'books#create'
  resources :books, only: [:new, :create, :index, :show]
end