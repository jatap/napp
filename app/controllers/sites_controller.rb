# Sites Controller Class.
#
# @author julio.antunez.tarin@gmail.com
class SitesController < AuthenticationController
  # Authorization
  before_filter :set_authorization

  # View variables
  before_action :set_sidebar_active_action

  # Show action.
  #
  # @return [void]
  def show
    @site = Site.find(params[:id]).decorate
    respond_to do |format|
      format.html
      format.json
    end
  end

  # Edit action.
  #
  # @return [void]
  def edit
    @site = Site.find(params[:id]).decorate
  end

  # Update action.
  #
  # @return [void]
  def update
    successfully_updated = @site.update(site_params)

    respond_to do |format|
      if successfully_updated
        format.html { redirect_to site_path, notice: t('crud.flash.edit') }
        format.json { render :edit, status: :ok, location: @site, json: @site }
      else
        format.html { render :edit }
        format.json { render json: @site.errors, status: :unprocessable_entity }
      end
    end
  end

  # Set sideber active to handle CSS markup.
  #
  # @return [void]
  def set_sidebar_active_action
    @sidebar_active = 'site'
  end

  # Never trust parameters from the scary internet, only allow the white list
  # through.
  #
  # @return [void]
  def site_params
    params.require(:site).permit(
      :name, :version, :author, :banner, :email, :twitter, :facebook, :linkedin,
      :google_plus
    )
  end
  private :site_params

  # Set authorization to pundit proccess.
  #
  # @return [void]
  def set_authorization
    @site = Site.find(params[:id]).decorate
    authorize @site
  end
  private :set_authorization
end
