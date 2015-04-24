# == Schema Information
#
# Table name: sites
#
#  id          :integer          not null, primary key
#  name        :string
#  version     :string
#  author      :string
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

FactoryGirl.define do
  factory :site do
    name { Faker::Lorem.sentence(2) }
    version { Faker::App.version }
    author { Faker::Name.name }
    banner { Faker::Lorem.sentence }
    sequence(:email) { |n| "site#{n}@example.com" }
    twitter { Faker::Internet.url }
    facebook { Faker::Internet.url }
    linkedin { Faker::Internet.url }
    google_plus { Faker::Internet.url }
  end
end
