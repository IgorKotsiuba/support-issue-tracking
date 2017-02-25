FactoryGirl.define do
  factory :ticket do
    user
    status
    sequence(:customer_email)   { Faker::Internet.email }
    customer_name               { Faker::Name.name }
    subject                     { Faker::Lorem.sentence }
    sequence(:reference_number) { Faker::Code.imei }
    issue_department            { Faker::Commerce.department }
  end
end
