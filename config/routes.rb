# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      post 'login', to: 'authentication#create'
      post 'register', to: 'users#create'

      resources :events do
        member do
          get :edit
          get :toggle_pin
        end
      end
    end
  end
end
