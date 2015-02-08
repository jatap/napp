# Site policy Class.
#
# @!attribute [r] site
#   @return [Site] the current site
# @author julio.antunez.tarin@gmail.com
class SitePolicy < ApplicationPolicy
  attr_reader :site

  # Show method policy.
  #
  # @return [Boolean] the permission (only :admin).
  def show?
    user.admin?
  end

  # Edit method policy.
  #
  # @return [Boolean] the permission (only :admin).
  def edit?
    user.admin?
  end

  # Update method policy.
  #
  # @return [Boolean] the permission (only :admin).
  def update?
    user.admin?
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
