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

FactoryGirl.define do
  factory :user_profile do
    first_name Faker::Name.first_name
    last_name Faker::Name.last_name
    website Faker::Internet.url
    phone Faker::PhoneNumber.phone_number
    user { build(:user) }
  end
end
