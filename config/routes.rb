Rails.application.routes.draw do

  # Root
  get '/:locale' => 'frontend#home'
  root to: 'frontend#home'

  # Translated routes
  scope "(:locale)", locale: /es|en/ do

    # Frontend
    get 'frontend/home'
    get 'frontend/about'

    # Backend
    get 'backend/dashboard'

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
