Rails.application.routes.draw do

  # Root
  get '/:locale' => 'frontend#home'
  root to: 'frontend#home'

  # Translated routes
  localized do

    # Frontend
    get 'frontend/about'

    # Backend
    get 'backend/dashboard'

    # CRUD
    scope '/backend' do
      resources :users
    end

    devise_for :users, controllers: {
      confirmations:      "users/confirmations",
      passwords:          "users/passwords",
      registrations:      "users/registrations",
      sessions:           "users/sessions",
      unlocks:            "users/unlocks"
    },
    path: "backend/users"
  end
end
