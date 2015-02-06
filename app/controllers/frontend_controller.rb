# Frontend Controller Class.
#
# @author julio.antunez.tarin@gmail.com
class FrontendController < ApplicationController
  # Layout
  layout 'frontend'

  # Load site
  before_action :load_site

  # Home action.
  #
  # @return [void]
  def home
  end

  # About action.
  #
  # @return [void]
  def about
  end

  # Load site model
  #
  # @return [void]
  def load_site
    @site = Site.first
  end
  private :load_site
end
