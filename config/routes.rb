Rails.application.routes.draw do

  # Root
  get '/en' => 'frontend#home', locale: :en, as: 'root_en'
  get '/es' => 'frontend#home', locale: :es, as: 'root_es'
  root to: 'frontend#home'

  # Error pages
  %w( 404 422 500 ).each do |code|
    get code, to: 'errors#show', code: code
  end


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
      passwords:          "users/passwords",
      registrations:      "users/registrations",
      sessions:           "users/sessions"
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
