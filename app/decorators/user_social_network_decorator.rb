# UserSocialNetwork decorator Class.
#
# @author julio.antunez.tarin@gmail.com
class UserSocialNetworkDecorator < Draper::Decorator
  delegate_all

  decorates_finders
end
