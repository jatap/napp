# Users Module Class.
#
# @author julio.antunez.tarin@gmail.com
module Users
  # Passwords Controller Class.
  #
  # @author julio.antunez.tarin@gmail.com
  class PasswordsController < Devise::PasswordsController
    # Layout
    layout 'frontend'
  end
end
