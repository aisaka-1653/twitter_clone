# frozen_string_literal: true

Rails.application.routes.draw do
  get 'follows/create'
  get 'follows/destroy'
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations'
  }
  root 'homes#index'
  resources :homes, only: %i[index]
  resources :users, only: %i[show edit update]
  resources :users do
    resource :follows, only: %i[create destroy]
  end
  resources :tweets, only: %i[create show]
  resources :tweets do
    resources :comments, only: %i[create]
    resources :likes, only: %i[create destroy]
    resources :retweets, only: %i[create destroy]
    resources :bookmarks, only: %i[create destroy]
  end
  resources :bookmarks, only: %i[index]
  resources :rooms, only: %i[index create show] do
    resources :messages, only: %i[create]
  end
  resources :notifications, only: %i[index]
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
  resources :tasks
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
end
