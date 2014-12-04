Rails.application.routes.draw do
  get 'admin/dashboard'

  devise_for :users, controllers: { registrations: "registrations" },
                     path: 'admin/users',
                     path_names: { sign_in: 'login', sign_out: 'logout' }
  root to: 'visitors#index'
end
