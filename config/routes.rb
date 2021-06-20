Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  devise_for :users, controllers: { sessions: 'users/sessions' }
  resources :users do
    collection do
      get 'dashboard'
    end
  end
  
  root to: "users#dashboard"
end
