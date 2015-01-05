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
end
