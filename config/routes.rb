Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      # Devise routes
      devise_for :users, controllers: {
        sessions: 'api/v1/sessions',
        registrations: 'api/v1/registrations',
        passwords: 'api/v1/passwords'
      }
      # Registration route

      # User routes
      resources :users, only: [:show, :index, :destroy] do
        resources :therapists, only: [:index, :show, :create, :destroy]
        resources :appointments, only: [:index, :show, :create, :destroy]
      end
    end
  end
end
