# User policy Class.
#
# @!attribute [r] user
#   @return [User] the current user
# @author julio.antunez.tarin@gmail.com
class UserPolicy < ApplicationPolicy
  attr_reader :user

  # Show method policy.
  #
  # @return [Boolean] the permission (only :admin).
  def show?
    user.admin? || user.fullname == record.fullname
  end

  # Edit method policy.
  #
  # @return [Boolean] the permission (only :admin).
  def edit?
    user.admin? || user.fullname == record.fullname
  end

  # Update method policy.
  #
  # @return [Boolean] the permission (only :admin).
  def update?
    user.admin? || user.fullname == record.fullname
  end

  # Destroy method policy.
  #
  # @return [Boolean] the permission (only :admin).
  def destroy?
    user.admin?
  end

  # New method policy.
  #
  # @return [Boolean] the permission (only :admin).
  def new?
    user.admin?
  end

  # Create method policy.
  #
  # @return [Boolean] the permission (only :admin).
  def create?
    user.admin?
  end

  # Index method policy.
  #
  # @return [Boolean] the permission (only :admin).
  def index?
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
