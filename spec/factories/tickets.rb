# == Schema Information
#
# Table name: tickets
#
#  id               :integer          not null, primary key
#  subject          :string           not null
#  reference_number :string           not null
#  customer_id      :integer          not null
#  manager_id       :integer
#  status_id        :integer          not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_tickets_on_reference_number  (reference_number) UNIQUE
#

FactoryGirl.define do
  factory :ticket do
    association :customer, factory: :user
    association :manager, factory: :user
    status
    subject                     { Faker::Lorem.sentence }
    sequence(:reference_number) { Faker::Code.imei }
  end
end
