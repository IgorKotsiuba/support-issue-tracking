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

class Message < ApplicationRecord
  belongs_to :ticket
  belongs_to :user, optional: true

  validates :body, presence: true

  def author
    user_id.present? ? user.username : ticket.customer_name
  end
end
