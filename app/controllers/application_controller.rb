# Application Controller Class.
#
# @author julio.antunez.tarin@gmail.com
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

  # Internationalization in JS (gon)
  before_action :set_js_locale

  # Load site
  before_action :load_site

  # Avoid set up locale automaticallty from url param when available
  # @see route_translator
  skip_around_filter :set_locale_from_url

  # After sign in path.
  #
  # @param [String] resource_or_scope the resource or scope.
  # @return [String] the required path.
  def after_sign_in_path_for(_resource_or_scope)
    backend_dashboard_path
  end

  # After sign up path.
  #
  # @param [String] resource the resource.
  # @return [String] the required path.
  def after_sign_up_path_for(resource)
    after_sign_in_path_for(resource)
  end

  # After sign out path.
  #
  # @note Default locale is ommited.
  # @param (see #after_sign_up_path_for)
  # @return [String] the required path.
  def after_sign_out_path_for(_resource)
    I18n.locale == I18n.default_locale ? '/' : "/#{I18n.locale}"
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

  # Set locale and default_locale in JS.
  #
  # @visibility protected
  #
  # @return [Symbol] the locale, `:en` or `:es` as default ones
  def set_js_locale
    gon.default_locale = I18n.default_locale
    gon.locale         = I18n.locale
    gon.full_locale    = I18n.full_locale
  end
  protected :set_js_locale

  # Set default URL options.
  #
  # @param [Hash] options.
  # @return [void]
  def default_url_options(options = {})
    if I18n.locale.to_sym.eql?(I18n.default_locale.to_sym) ||
       params[:locale]
      {}.merge(options)
    else
      { locale: I18n.locale }.merge(options)
    end
  end

  # Rewrite pundit/authorization notification message.
  #
  # :nocov:
  # @param [Pundit::NotAuthorizedError] exception the exception.
  # @return [void]
  def user_not_authorized(exception)
    # Prevent wrong link building
    set_locale
    # Set flash message
    policy_name = exception.policy.class.to_s.underscore
    flash[:error] = t("#{policy_name}.#{exception.query}", scope: 'pundit',
                                                           default: :default)
    # Redirect
    redirect_to(request.referrer || root_path)
  end
  private :user_not_authorized
  # :nocov:

  # Load site model
  #
  # @return [void]
  def load_site
    @site = Site.first
  end
  private :load_site
end
