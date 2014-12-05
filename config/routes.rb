Rails.application.routes.draw do

  # Frontend
  get 'frontend/home'
  get 'frontend/about'

  # Backend
  get 'admin/dashboard'

  devise_for :users, controllers: {
                       confirmations:      "devise/custom/confirmations",
                       passwords:          "devise/custom/passwords",
                       registrations:      "devise/custom/registrations",
                       sessions:           "devise/custom/sessions",
                       unlocks:            "devise/custom/unlocks"
                     },
                     path_prefix: 'admin'

  # Root
  root to: 'frontend#home'

end
