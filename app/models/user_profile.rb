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
