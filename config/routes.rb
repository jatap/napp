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

    devise_for :users,  path: "backend/users", controllers: {
      confirmations:      "users/confirmations",
      passwords:          "users/passwords",
      registrations:      "users/registrations",
      sessions:           "users/sessions",
      unlocks:            "users/unlocks"
    }


    # CRUD

    concern :paginatable do
      get '(page/:page)', action: :index, on: :collection, as: ''
    end

    scope '/backend' do
      scope '/crud' do
        resources :users, concerns: :paginatable
      end
    end
  end
end
