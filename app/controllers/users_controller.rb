class UsersController < ApplicationController
  layout 'backend'

  before_filter :authenticate_user!

  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # View variables
  before_action :set_sidebar_active_action

  def index
    # @users = User.all.references(:roles).page params[:page]
    respond_to do |format|
      format.html
      format.json { render json: UserDatatable.new(view_context) }
    end
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

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

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: t('crud.flash.destroy') }
      format.json { head :no_content }
    end
  end

  def set_sidebar_active_action
    @sidebar_active = 'users'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:fullname, :email, :password,
                                   :password_confirmation, role_ids: [] )
    end

    def needs_password?(user, params)
      params[:password].present?
    end
end
