FactoryGirl.define do
  factory :ticket do
    association :customer, factory: :user
    association :manager, factory: :user
    status
    subject                     { Faker::Lorem.sentence }
    sequence(:reference_number) { Faker::Code.imei }
  end
end
