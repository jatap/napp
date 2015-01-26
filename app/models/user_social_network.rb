# == Schema Information
#
# Table name: user_social_networks
#
#  id          :integer          not null, primary key
#  twitter     :string
#  facebook    :string
#  google_plus :string
#  instagram   :string
#  youtube     :string
#  whatsup     :string
#  linkedin    :string
#  pinterest   :string
#  flickr      :string
#  digg        :string
#  reddit      :string
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_user_social_networks_on_user_id  (user_id)
#

# UserSocialNetwork Model
#
# @author julio.antunez.tarin@gmail.com
class UserSocialNetwork < ActiveRecord::Base
  # Master association
  belongs_to :user, inverse_of: :social_network

  # To string representation of model.
  #
  # @return [String] the twitter account
  def to_s
    twitter
  end
end
