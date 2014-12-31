# Users Controller Class.
#
# @author julio.antunez.tarin@gmail.com
class UsersController < ApplicationController

  # Layout
  layout 'backend'

  # Authentication
  before_filter :authenticate_user!

  # Set user
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # View variables
  before_action :set_sidebar_active_action

  # Authorization
  before_filter :set_authorization

  # Index action.
  #
  # @note AJAX proccess via DataTables.
  # @return [void]
  def index
    respond_to do |format|
      format.html
      format.json { render json: UserDatatable.new(view_context) }
    end
  end

  # Show action.
  #
  # @return [void]
  def show
  end

  # New action.
  #
  # @return [void]
  def new
    @user = User.new
  end

  # Edit action.
  #
  # @return [void]
  def edit
  end

  # Create action.
  #
  # @return [void]
  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        format.html { redirect_to users_path, notice: t('crud.flash.add') }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
  alias_method :insert, :create

  # Update action.
  #
  # @return [void]
  def update
    if user_params[:password].blank?
      user_params.delete(:password)
      user_params.delete(:password_confirmation)
    end

    successfully_updated = if needs_password?(@user, user_params)
                             @user.update(user_params)
                           else
                             @user.update_without_password(user_params)
                           end

    respond_to do |format|
      if successfully_updated
        format.html { redirect_to users_path, notice: t('crud.flash.edit') }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # Destroy action.
  #
  # @return [void]
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: t('crud.flash.destroy') }
      format.json { head :no_content }
    end
  end

  # Set sideber active to handle CSS markup.
  #
  # @return [void]
  def set_sidebar_active_action
    @sidebar_active = 'users'
  end

  # Use callbacks to share common setup or constraints between actions.
  #
  # @return [void]
  def set_user
    @user = User.find(params[:id])
  end
  private :set_user

  # Never trust parameters from the scary internet, only allow the white list
  # through.
  #
  # @return [void]
  def user_params
    params.require(:user).permit(:fullname, :email, :password,
                                 :password_confirmation, role_ids: [] )
  end
  private :user_params

  # Check if user has write some date in password form element.
  #
  # @return [Boolean] the check result.
  def needs_password?(user, params)
    params[:password].present?
  end
  private :needs_password?

  # Set authorization to pundit proccess.
  #
  # @return [void]
  def set_authorization
    @user ||= current_user
    authorize @user
  end
  private :set_authorization

end
