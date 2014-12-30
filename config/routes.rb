Rails.application.routes.draw do

  # Root
  get '/en' => 'frontend#home', locale: :en
  root to: 'frontend#home'

  # Beanstalkd
  scope '/backend' do
    mount BeanstalkdView::Server, at: "/jobs"
  end

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
