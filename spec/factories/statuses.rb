# == Schema Information
#
# Table name: statuses
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :status do
    sequence(:name) { Faker::Lorem.word }
  end
end
