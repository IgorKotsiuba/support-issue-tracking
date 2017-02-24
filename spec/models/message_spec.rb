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

require 'rails_helper'

RSpec.describe Message, type: :model do
  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:ticket) }

  it { is_expected.to validate_presence_of :body }
end
