# Role model Class.
#
# @author julio.antunez.tarin@gmail.com
class Role < ActiveRecord::Base
  has_and_belongs_to_many :users, join_table: :users_roles
  belongs_to :resource, polymorphic: true

  # Rolify
  scopify

  # String representation.
  #
  # @return [String] the name.
  def to_s
    name
  end
end
