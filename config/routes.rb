# frozen_string_literal: true

Rails.application.routes.draw do
  # root "articles#index"

  namespace :api do
    namespace :v1 do
      # authentication
      resources :users, only: %i[create show]
      resource :user_sessions, only: %i[create destroy show]
      post 'register' => 'users#create'
      post 'login' => 'user_sessions#create'
      get 'logout' => 'user_sessions#destroy'
      get 'session' => 'user_sessions#show'

      # trading routes
      resources :trades, only: %i[create]
      resources :transfer_list, only: %i[index]

      # models
      resources :teams, only: %i[show update] do
        scope module: :teams do
          resources :players, only: %i[index show update]
        end
      end
    end
  end
end
