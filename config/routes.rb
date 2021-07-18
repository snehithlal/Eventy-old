# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :friend_lists, only: [:index, :create, :destroy] do
        collection do
          get :accept
          get :search
        end
      end

      post 'login', to: 'authentication#create'
      post 'register', to: 'users#create'

      resources :events
    end
  end
end
