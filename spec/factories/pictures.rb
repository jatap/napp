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

FactoryGirl.define do
  factory :picture do
    avatar ''
    avatar_url Faker::Company.logo
  end
end
