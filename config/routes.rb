Rails.application.routes.draw do

  get 'frontend/home'
  get 'frontend/about'

  get 'admin/dashboard'

  devise_for :users, controllers: { registrations: "registrations" },
                     path_prefix: 'admin',
                     path_names: { sign_in: 'login', sign_out: 'logout' }

  devise_scope :user do
    get "login"         => "devise/sessions#new"
    delete "logout"     => "devise/sessions#destroy"
    get "lost_password" => "devise/passwords#new"
    get "register"      => "registrations#new"
  end

  root to: 'frontend#home'

end
