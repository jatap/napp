# Users Module Class.
#
# @author julio.antunez.tarin@gmail.com
module Users
  # Registrations Controller Class.
  #
  # @author julio.antunez.tarin@gmail.com
  class RegistrationsController < Devise::RegistrationsController
    # Layout
    layout 'frontend'

    # Edit action.
    #
    # @return [void]
    def edit
      Users::RegistrationsController.layout 'backend'
      super
      Users::RegistrationsController.layout 'frontend'
    end

    # Update action.
    #
    # @return [void]
    def update
      Users::RegistrationsController.layout 'backend'
      super
      Users::RegistrationsController.layout 'frontend'
    end

    # After update path (devise).
    #
    # @return [String] the required path.
    def after_update_path_for(_resource)
      backend_dashboard_path
    end

    # Sign up params.
    #
    # @return [void]
    def sign_up_params
      params.require(:user).permit(:fullname, :email, :password,
                                   :password_confirmation)
    end
    private :sign_up_params

    # Account update params.
    #
    # @return [void]
    def account_update_params
      params.require(:user).permit(
        :fullname, :email, :password, :slug,
        :password_confirmation, :current_password,
        profile_attributes: [:first_name, :last_name, :website, :twitter,
                             :facebook, :google, :phone])
    end
    private :account_update_params
  end
end
