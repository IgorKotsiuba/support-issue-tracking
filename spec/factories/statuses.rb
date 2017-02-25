FactoryGirl.define do
  factory :status do
    sequence(:name) { Faker::Lorem.word }
  end
end
