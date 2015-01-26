# == Schema Information
#
# Table name: user_profiles
#
#  id         :integer          not null, primary key
#  first_name :string
#  last_name  :string
#  website    :string
#  phone      :string
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_user_profiles_on_user_id  (user_id)
#

# UserProfile Model
#
# @author julio.antunez.tarin@gmail.com
class UserProfile < ActiveRecord::Base
  # Master association
  belongs_to :user, inverse_of: :profile

  # To string representation of model.
  #
  # @return [String] the profile with first_name and last_name
  def to_s
    [first_name, last_name].join(' ')
  end
end
