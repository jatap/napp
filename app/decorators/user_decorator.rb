# User decorator Class.
#
# @author julio.antunez.tarin@gmail.com
class UserDecorator < Draper::Decorator
  delegate_all

  decorates_association :user_profile
  decorates_association :user_social_network
  decorates_association :picture

  decorates_finders
end
