# Picture decorator Class.
#
# @author julio.antunez.tarin@gmail.com
class PictureDecorator < Draper::Decorator
  delegate_all

  decorates_finders
end
