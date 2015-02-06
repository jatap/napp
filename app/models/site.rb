# == Schema Information
#
# Table name: sites
#
#  id          :integer          not null, primary key
#  name        :string
#  version     :string
#  author      :string
#  banner      :string
#  email       :string
#  twitter     :string
#  facebook    :string
#  linkedin    :string
#  google_plus :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_sites_on_name  (name) UNIQUE
#

# Site model Class.
#
# @author julio.antunez.tarin@gmail.com
class Site < ActiveRecord::Base
  # Validations
  validates :name, presence: true, uniqueness: true
  validates :banner, presence: true
  validates :email, presence: true, email: true
  validates :twitter, presence: true, url: true
  validates :facebook, presence: true, url: true
  validates :linkedin, presence: true, url: true
  validates :google_plus, presence: true, url: true

  # To string representation of model.
  #
  # @return [String] the name
  def to_s
    name
  end
end
