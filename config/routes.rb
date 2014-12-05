Rails.application.routes.draw do

  # Frontend
  get 'frontend/home'
  get 'frontend/about'

  # Backend
  get 'admin/dashboard'

  devise_for :users, controllers: {
                       confirmations:      "users/confirmations",
                       passwords:          "users/passwords",
                       registrations:      "users/registrations",
                       sessions:           "users/sessions",
                       unlocks:            "users/unlocks"
                     },
                     path_prefix: 'admin'

  # Root
  root to: 'frontend#home'

end
