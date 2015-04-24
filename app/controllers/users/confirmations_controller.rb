# Users Module Class.
#
# @author julio.antunez.tarin@gmail.com
module Users
  # Confirmation Controller Class.
  #
  # @author julio.antunez.tarin@gmail.com
  class ConfirmationsController < Devise::ConfirmationsController
    # Layout
    layout 'frontend'
  end
end
