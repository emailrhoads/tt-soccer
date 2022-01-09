# frozen_string_literal: true

Rails.application.routes.draw do
  # root "articles#index"

  namespace :api do
    namespace :v1 do
      # authentication
      resources :users, only: [:create]
      resource :user_sessions, only: %i[create destroy show]
      post 'register' => 'users#create'
      post 'login' => 'user_sessions#create'
      get 'logout' => 'user_sessions#destroy'
      get 'session' => 'user_sessions#show'

      # models
      resources :teams, only: [:show, :update] do
        scope module: :teams do
          resource :players, only: [:index, :show, :update]
        end
      end
    end
  end
end
