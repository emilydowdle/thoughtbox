Rails.application.routes.draw do
  root 'links#index'
  resources :links, only: [:index, :new, :create, :update, :destroy]
  resources :users, only: [:new, :create, :update]
  get '/login', to: "session#new"
  post '/login', to: "session#create"
  delete '/logout', to: "session#destroy"
end
