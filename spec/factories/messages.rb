# == Schema Information
#
# Table name: messages
#
#  id         :integer          not null, primary key
#  body       :text             not null
#  ticket_id  :integer
#  user_id    :integer
#  read       :boolean          default("false")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_messages_on_ticket_id  (ticket_id)
#  index_messages_on_user_id    (user_id)
#

FactoryGirl.define do
  factory :message do
    ticket
    user
    body { Faker::Lorem.sentence }
    read false
  end
end
