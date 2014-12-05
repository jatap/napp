class Users::RegistrationsController < Devise::RegistrationsController

  layout 'frontend'

  def edit
    Users::RegistrationsController.layout 'backend'
    super
    Users::RegistrationsController.layout 'frontend'
  end

  def update
    Users::RegistrationsController.layout 'backend'
    super
  end

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

  def sign_up_params
    params.require(:user).permit(:fullname, :email, :password, :password_confirmation)
  end
  private :sign_up_params

  def account_update_params
    params.require(:user).permit(:fullname, :email, :password, :password_confirmation, :current_password)
  end
  private :account_update_params
end
