# User model Class.
#
# @author julio.antunez.tarin@gmail.com
class User < ActiveRecord::Base

  # Roles
  rolify

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Check role
  before_create :check_role!

  # Mail notification to main admin user
  after_create :admin_notify

  # Check if user has admin role.
  #
  # @return [Boolean] the check result.
  def is_admin?
    has_role? :admin
  end
  alias_method :admin?, :is_admin?

  # Check if user has editor role.
  #
  # @return (see #is_admin?)
  def is_editor?
    has_role? :editor
  end
  alias_method :editor?, :is_editor?

  # Check if user has user role.
  #
  # @return (see #is_admin?)
  def is_user?
    has_role? :user
  end
  alias_method :user?, :is_user?

  # Send a notification mail when a user signs up.
  #
  # @return [void]
  def admin_notify
    UserMailer.signup_notification(self).deliver
  end
  private :admin_notify

  # Add user role when none is supplied.
  #
  # @return [void]
  def check_role!
    add_role :user if roles.blank?
  end
  private :check_role!

end
