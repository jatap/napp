class User < ActiveRecord::Base
  # Roles
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def is_admin?
    has_role? :admin
  end
  alias_method :admin?, :is_admin?

  def is_editor?
    has_role? :editor
  end
  alias_method :editor?, :is_editor?

  def is_user?
    has_role? :user
  end
  alias_method :user?, :is_user?
end
