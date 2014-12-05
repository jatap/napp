class ApplicationController < ActionController::Base
  include Pundit

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  layout 'frontend'

  def after_sign_in_path_for(resource_or_scope)
     backend_dashboard_path
  end

  def after_sign_up_path_for(resource)
      after_sign_in_path_for(resource)
  end
end
