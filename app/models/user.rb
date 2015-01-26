# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default("0"), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  created_at             :datetime
#  updated_at             :datetime
#  fullname               :string
#  slug                   :string           not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_slug                  (slug) UNIQUE
#

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
  validates :slug, uniqueness: true

  # Roles callbacks to handle minimum existence of one element
  after_initialize :check_role!
  after_create :check_role!
  after_update :check_role!
  after_save :check_role!

  # Mail notification to main admin user
  after_create :admin_notify

  # Profile association
  has_one :profile, validate: true, dependent: :destroy, inverse_of: :user,
                    class_name: 'UserProfile'
  accepts_nested_attributes_for :profile

  # Slug
  extend FriendlyId
  friendly_id :fullname, use: [:slugged]

  # Image
  attr_accessor :remove_picture
  has_one :picture, validate: true, dependent: :destroy, inverse_of: :user,
                    class_name: 'Picture'
  accepts_nested_attributes_for :picture

  # Social network
  has_one :social_network, validate: true, dependent: :destroy,
                           inverse_of: :user,
                           class_name: 'UserSocialNetwork'
  accepts_nested_attributes_for :social_network

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

  # Check when regenerate slug.
  #
  # @return [Boolean] the check result
  def should_generate_new_friendly_id?
    slug.blank?
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
