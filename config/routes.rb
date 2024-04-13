# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  root 'homes#index'
  resources :homes, only: %i[index]
  resources :tasks
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
end
