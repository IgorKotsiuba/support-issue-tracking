FactoryGirl.define do
  factory :user do
    sequence(:email)      { Faker::Internet.email }
    password              '1234567890'
    password_confirmation '1234567890'
    department            { Faker::Commerce.department }
  end
end
