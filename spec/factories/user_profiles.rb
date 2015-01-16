FactoryGirl.define do
  factory :user_profile do
    first_name Faker::Name.first_name
    last_name Faker::Name.last_name
    website Faker::Internet.url
    twitter '@new_user'
    facebook Faker::Internet.url
    google Faker::Internet.url
    phone Faker::PhoneNumber.phone_number
    user { build(:user) }
  end
end
