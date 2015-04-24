class SettingsController < AuthenticationController
  # Authorization
  before_filter :set_authorization

  # View variables
  before_action :set_sidebar_active_action

  # Index action
  #
  # @return [void]
  def index
    @settings = Setting.unscoped
  end

  # Update all action
  #
  # @return [void]
  def update_all
    settings = settings_params
    settings.each do |name, value|
      Setting[name.to_sym] = value
    end

    respond_to do |format|
      flash[:notice] = t('crud.flash.edit')
      format.html { redirect_to all_settings_path }
    end
  end

  # Set sideber active to handle CSS markup.
  #
  # @return [void]
  def set_sidebar_active_action
    @sidebar_active = 'settings'
  end

  # Never trust parameters from the scary internet, only allow the white list
  # through.
  #
  # @return [void]
  def settings_params
    params[:update_all_settings]
  end
  private :settings_params

  # Set authorization to pundit proccess.
  #
  # @return [void]
  def set_authorization
    settings = Setting.all
    settings.each do |setting|
      authorize setting
    end
  end
  private :set_authorization
end
