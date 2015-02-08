# Site decorator Class.
#
# @author julio.antunez.tarin@gmail.com
class SiteDecorator < Draper::Decorator
  delegate_all

  decorates_finders
end
