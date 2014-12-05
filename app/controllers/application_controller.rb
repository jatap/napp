class ApplicationController < ActionController::Base
  include Pundit

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  layout 'frontend'

  before_filter :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:fullname, :email, :password, :password_confirmation)
    end
    devise_parameter_sanitizer.for(:account_update) do |u|
      u.permit(:fullname, :email, :password, :password_confirmation, :current_password)
    end
  end

  def after_sign_in_path_for(resource_or_scope)
     admin_dashboard_path
  end

  def after_sign_up_path_for(resource)
      after_sign_in_path_for(resource)
  end
end
