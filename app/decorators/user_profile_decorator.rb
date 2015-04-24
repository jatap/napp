# UserProfile decorator Class.
#
# @author julio.antunez.tarin@gmail.com
class UserProfileDecorator < Draper::Decorator
  delegate_all

  decorates_finders
end
