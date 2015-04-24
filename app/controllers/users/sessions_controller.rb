# Users Module Class.
#
# @author julio.antunez.tarin@gmail.com
module Users
  # Sessions Controller Class.
  #
  # @author julio.antunez.tarin@gmail.com
  class SessionsController < Devise::SessionsController
    # Layout
    layout 'frontend'
  end
end
