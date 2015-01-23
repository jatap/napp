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
