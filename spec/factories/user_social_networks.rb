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

FactoryGirl.define do
  factory :user_social_network do
    twitter 'twitter'
    facebook 'facebook'
    google_plus 'google_plus'
    instagram 'instagram'
    youtube 'youtube'
    whatsup 'whatsup'
    linkedin 'linkedin'
    pinterest 'pinterest'
    flickr 'flickr'
    digg 'digg'
    reddit 'reddit'
  end
end
