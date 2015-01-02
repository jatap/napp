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

  # Validations
  validates :fullname, presence: true, uniqueness: true

  # Roles callbacks to handle minimum existence of one element
  after_initialize :check_role!
  after_create :check_role!
  after_update :check_role!
  after_save :check_role!

  # Mail notification to main admin user
  after_create :admin_notify

  # To string representation of model.
  #
  # @return [String] the username
  def to_s
    fullname
  end

  # Check if user has admin role.
  #
  # @return [Boolean] the check result.
  def admin?
    has_role? :admin
  end

  # Check if user has editor role.
  #
  # @return (see #is_admin?)
  def editor?
    has_role? :editor
  end

  # Check if user has user role.
  #
  # @return (see #is_admin?)
  def user?
    has_role? :user
  end

  # Send a notification mail when a user signs up.
  #
  # @return [void]
  def admin_notify
    UserMailer.signup_notification(self).deliver_later!(wait: 1.minute)
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
