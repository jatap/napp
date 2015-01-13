# Errors Controller Class.
#
# @author julio.antunez.tarin@gmail.com
class ErrorsController < ApplicationController
  # Layout
  layout 'frontend'

  # Internal (500) error.
  #
  # @return [void]
  def show
    render status_code.to_s, status: status_code
  end

  # Show error page by status code.
  #
  # @return [void]
  def status_code
    params[:code] || 500
  end
  protected :status_code
end
