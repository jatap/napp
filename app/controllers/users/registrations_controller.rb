# Users Registrations Controller Class.
#
# @author julio.antunez.tarin@gmail.com
class Users::RegistrationsController < Devise::RegistrationsController

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

  # Create action.
  #
  # @return [void]
  def create
    build_resource(sign_up_params)

    # Set :user as a default role
    resource.add_role :user

    if resource.save
      yield resource if block_given?
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_flashing_format?
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      respond_with resource
    end
  end

  # After update path (devise).
  #
  # @return [String] the required path.
  def after_update_path_for(resource)
    backend_dashboard_path
  end

  # Sign up params.
  #
  # @return [void]
  def sign_up_params
    params.require(:user).permit(:fullname, :email, :password, :password_confirmation)
  end
  private :sign_up_params

  # Account update params.
  #
  # @return [void]
  def account_update_params
    params.require(:user).permit(:fullname, :email, :password, :password_confirmation, :current_password)
  end
  private :account_update_params

end
