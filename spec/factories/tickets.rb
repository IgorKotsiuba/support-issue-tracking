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
#  index_tickets_on_customer_email    (customer_email) UNIQUE
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
    url_token                   { Faker::Internet.url }

    # after(:build) { |ticket| ticket.class.skip_callback(:validation, :after, :set_reference_token, :set_url_token) }

    trait :without_validations do
      to_create { |instance| instance.save(validate: false) }
      url_token 'default'
    end
  end
end
