# Setting policy Class.
#
# @!attribute [r] setting
#   @return [Setting] the current setting
# @author julio.antunez.tarin@gmail.com
class SettingPolicy < ApplicationPolicy
  attr_reader :setting

  # Index method policy.
  #
  # @return [Boolean] the permission (only :admin).
  def index?
    user.user?
  end

  # Update all method policy.
  #
  # @return [Boolean] the permission (only :admin).
  def update_all?
    user.user?
  end

  # Scope Class.
  #
  # @author julio.antunez.tarin@gmail.com
  class Scope < Scope
    # Resolve.
    #
    # @return [Scope] the scope.
    def resolve
      scope
    end
  end
end
