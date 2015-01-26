# == Schema Information
#
# Table name: pictures
#
#  id                  :integer          not null, primary key
#  avatar_file_name    :string
#  avatar_content_type :string
#  avatar_file_size    :integer
#  avatar_updated_at   :datetime
#  avatar_url          :string
#  user_id             :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
# Indexes
#
#  index_pictures_on_user_id  (user_id)
#

# Picture model Class.
#
# @author julio.antunez.tarin@gmail.com
class Picture < ActiveRecord::Base
  # Master association
  belongs_to :user, inverse_of: :picture

  has_attached_file :avatar,
                    styles: { medium: '300x300>', thumb: '100x100>' },
                    default_url: '/images/:style/missing.png'
  validates_attachment :avatar, content_type: { content_type: /\Aimage\/.*\Z/ }
  validates :avatar, attachment_size: { less_than: 1.megabytes }
  before_update :avatar_url

  # String representation.
  #
  # @return [String] the avatar url.
  def to_s
    avatar_url
  end

  # Avatar URL (delegates from avatar).
  #
  # @param [Symbol] size the image size.
  # @return [void]
  def avatar_url(size = :thumb)
    return nil unless avatar.present?
    avatar.url size
  end
end
