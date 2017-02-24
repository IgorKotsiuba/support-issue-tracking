# == Schema Information
#
# Table name: messages
#
#  id        :integer          not null, primary key
#  body      :text             not null
#  ticket_id :integer
#  user_id   :integer
#  read      :boolean          default("false")
#
# Indexes
#
#  index_messages_on_ticket_id  (ticket_id)
#  index_messages_on_user_id    (user_id)
#

class Message < ApplicationRecord
  belongs_to :ticket
  belongs_to :user

  validates :body, presence: true
end
