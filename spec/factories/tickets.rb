FactoryGirl.define do
  factory :ticket do
    customer
    manager
    status
    subject                     { Faker::Lorem.sentence }
    sequence(:reference_number) { Faker::Code.imei }
  end
end
