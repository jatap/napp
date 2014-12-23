# Backend Controller Class.
#
# @author julio.antunez.tarin@gmail.com
class BackendController < ApplicationController

  # Authentication
  before_filter :authenticate_user!

  # Layout
  layout 'backend'

  # Dashboard action.
  #
  # @return [void]
  def dashboard
  end

end
