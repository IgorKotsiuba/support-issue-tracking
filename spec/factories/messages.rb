FactoryGirl.define do
  factory :message do
    ticket
    user
    body { Faker::Lorem.sentence }
    read false
  end
end
