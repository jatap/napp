# Authentication Controller Class.
#
# @author julio.antunez.tarin@gmail.com
class AuthenticationController < ApplicationController
  # Authentication
  before_filter :authenticate_user!

  # Layout
  layout 'backend'
end
