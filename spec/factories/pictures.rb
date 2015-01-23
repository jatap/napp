FactoryGirl.define do
  factory :picture do
    avatar ''
    avatar_url Faker::Company.logo
  end
end
