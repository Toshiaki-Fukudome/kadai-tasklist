Rails.application.routes.draw do
  
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: 'sessions#destroy'

  #<% if logged_in? %>でいらなくなったget "toppage", to: "toppages#index"
  get "signup", to: "users#new"
  resources :users, only: [:create]
  
  root to: "tasks#index"
  resources :tasks
end
