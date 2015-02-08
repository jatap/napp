# Users Controller Class.
#
# @author julio.antunez.tarin@gmail.com
class UsersController < AuthenticationController
  # Set user
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # View variables
  before_action :set_sidebar_active_action

  # Authorization
  before_filter :set_authorization

  # ACL
  after_filter :verify_authorized

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
    @user = User.friendly.find(params[:id]).decorate
    respond_to do |format|
      format.html
      format.json
    end
  end

  # New action.
  #
  # @return [void]
  def new
    @user = User.new.decorate
  end

  # Edit action.
  #
  # @return [void]
  def edit
    #@user = User.friendly.find(params[:id])
    @user = User.friendly.find(params[:id]).decorate
  end

  # Create action.
  #
  # @return [void]
  def create
    @user = User.new(user_params)

    check_and_remove_picture!

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

    update_picture_avatar!
    check_and_remove_picture!

    successfully_updated = if needs_password?(@user, user_params)
                             @user.update(user_params)
                           else
                             @user.update_without_password(user_params)
                           end

    respond_to do |format|
      if successfully_updated
        format.html { redirect_to user_path, notice: t('crud.flash.edit') }
        format.json { render :edit, status: :ok, location: @user, json: @user }
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

  # Update picture avatar (remove related param when data comes empty).
  #
  # @return [void]
  def update_picture_avatar!
    return unless params[:user][:picture_attributes].present?
    avatar = params[:user][:picture_attributes][:avatar]
    params[:user].delete :picture_attributes if avatar.blank?
  end
  private :update_picture_avatar!

  # Check and remove picture.
  #
  # Check from request params and remove from model instance.
  #
  # @return [void]
  def check_and_remove_picture!
    if params[:user][:remove_picture] == '1'
      params[:user].delete :picture_attributes
      @user.picture.avatar = nil if @user.picture.present?
    end
    params[:user].delete :remove_picture
  end
  private :check_and_remove_picture!

  # Use callbacks to share common setup or constraints between actions.
  #
  # @return [void]
  def set_user
    @user = User.friendly.find(params[:id])
  end
  private :set_user

  # Never trust parameters from the scary internet, only allow the white list
  # through.
  #
  # @return [void]
  def user_params
    params.require(:user).permit(
      :fullname, :email, :password, :slug, :password_confirmation,
      :remove_picture,
      profile_attributes: [:first_name, :last_name, :website, :twitter,
                           :facebook, :google, :phone],
      role_ids: [], picture_attributes: [:avatar],
      social_network_attributes: [:twitter, :facebook, :google_plus,
                                  :instagram, :youtube, :whatsup, :linkedin,
                                  :pinterest, :flickr, :digg, :reddit])
  end
  private :user_params

  # Check if user has write some date in password form element.
  #
  # @return [Boolean] the check result.
  def needs_password?(_user, params)
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
