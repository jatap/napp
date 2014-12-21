class ApplicationController < ActionController::Base

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # ACL
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  # Layout
  layout 'frontend'

  # Internationalization
  before_action :set_locale

  def after_sign_in_path_for(resource_or_scope)
     backend_dashboard_path
  end

  def after_sign_up_path_for(resource)
    after_sign_in_path_for(resource)
  end

  def after_sign_out_path_for(resource)
    I18n.locale == I18n.default_locale ? "/" : "/#{I18n.locale}"
  end

  # Reads locale param in the url and setup the language, if empty sets to
  # default language.
  #
  # @visibility protected
  #
  # @return [Symbol] the locale, `:en` or `:es` as default ones
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
  protected :set_locale

  def default_url_options()
    I18n.locale.to_sym.eql?(I18n.default_locale.to_sym) ?
      {} :
      { locale: I18n.locale }
  end

  def user_not_authorized(exception)
    set_locale
    policy_name = exception.policy.class.to_s.underscore
    flash[:error] = t("#{policy_name}.#{exception.query}", scope: "pundit",
                                                           default: :default)
    redirect_to(request.referrer || root_path)
  end
  private :user_not_authorized
end
