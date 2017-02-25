FactoryGirl.define do
  factory :user do
    sequence(:email)      { Faker::Internet.email }
    sequence(:username)   { Faker::Internet.user_name }
    password              '1234567890'
    password_confirmation '1234567890'
  end
end
