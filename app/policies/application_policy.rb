# Application policy Class.
#
# @!attribute [r] user
#   @return [User] the current user
# @!attribute [r] record
#   @return [ActiveRecord::Base] the model to handle.
# @author julio.antunez.tarin@gmail.com
class ApplicationPolicy

  attr_reader :user, :record

  # Constructor.
  #
  # @return [void]
  def initialize(user, record)
    @user   = user
    @record = record
  end

  # Index method policy.
  #
  # @return [Boolean] the permission.
  def index?
    false
  end

  # Show method policy.
  #
  # @return [Boolean] the permission.
  def show?
    scope.where(:id => record.id).exists?
  end

  # Create method policy.
  #
  # @return [Boolean] the permission.
  def create?
    false
  end

  # New method policy.
  #
  # @return [Boolean] the permission.
  def new?
    create?
  end

  # Update method policy.
  #
  # @return [Boolean] the permission.
  def update?
    false
  end

  # Edit method policy.
  #
  # @return [Boolean] the permission.
  def edit?
    update?
  end

  # Destroy method policy.
  #
  # @return [Boolean] the permission.
  def destroy?
    false
  end

  # Scope.
  #
  # @return [Boolean] the permission.
  def scope
    Pundit.policy_scope!(user, record.class)
  end

  # Scope Class.
  #
  # @!attribute [r] user
  #   @return [User] the current user
  # @!attribute [r] scope
  #   @return [Scope] the policy scope
  # @author julio.antunez.tarin@gmail.com
  class Scope

    attr_reader :user, :scope

    # Constructor.
    #
    # @return [void]
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    # Resolve.
    #
    # @return [Scope] the scope.
    def resolve
      scope
    end

  end

end

