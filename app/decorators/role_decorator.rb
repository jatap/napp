# Role decorator Class.
#
# @author julio.antunez.tarin@gmail.com
class RoleDecorator < Draper::Decorator
  delegate_all

  decorates_finders
end
