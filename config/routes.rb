# frozen_string_literal: true

Rails.application.routes.draw do
  get 'comments/create'
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations'
  }
  root 'homes#index'
  resources :homes, only: %i[index]
  resources :users, only: %i[show edit update]
  resources :tweets, only: %i[create show]
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
  resources :tasks
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
end
