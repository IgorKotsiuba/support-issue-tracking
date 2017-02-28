# == Schema Information
#
# Table name: tickets
#
#  id               :integer          not null, primary key
#  subject          :string           not null
#  reference_number :string           not null
#  user_id          :integer
#  status_id        :integer          not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  customer_name    :string           not null
#  customer_email   :string           not null
#  issue_department :string
#  url_token        :string           not null
#
# Indexes
#
#  index_tickets_on_reference_number  (reference_number) UNIQUE
#  index_tickets_on_url_token         (url_token) UNIQUE
#

FactoryGirl.define do
  factory :ticket do
    user
    status
    sequence(:customer_email)   { Faker::Internet.email }
    customer_name               { Faker::Name.name }
    subject                     { Faker::Lorem.sentence }
    sequence(:reference_number) { Faker::Code.imei }
    issue_department            { Faker::Commerce.department }
    sequence(:url_token)        { Faker::Internet.url }

    trait :without_validations do
      to_create { |instance| instance.save(validate: false) }
      sequence(:url_token) { Faker::Internet.url }
    end
  end
end
