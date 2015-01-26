# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default("0"), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  created_at             :datetime
#  updated_at             :datetime
#  fullname               :string
#  slug                   :string           not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_slug                  (slug) UNIQUE
#

FactoryGirl.define do
  factory :user do
    fullname { Faker::Name.name.downcase }
    # email { Faker::Internet.email }
    sequence(:email) { |n| "person#{n}@example.com" }
    password 'password'
    password_confirmation 'password'
  end

  factory :user_with_editor_role, parent: :user do
    roles { [build(:role, name: 'editor')] }
  end

  factory :user_with_user_role, parent: :user do
    roles { [build(:role, name: 'user')] }
  end

  factory :user_with_admin_role, parent: :user do
    roles { [build(:role, name: 'admin')] }
  end

  factory :user_without_password, parent: :user_with_editor_role do
    password nil
    password_confirmation nil
  end

  factory :invalid_user, parent: :user do
    fullname ''
    roles { [build(:role, name: 'user')] }
  end
end
