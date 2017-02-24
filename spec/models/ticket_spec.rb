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

require 'rails_helper'

RSpec.describe Ticket, type: :model do
  it { is_expected.to belong_to(:customer).class_name('User') }
  it { is_expected.to belong_to(:manager).class_name('User') }
  it { is_expected.to belong_to(:status) }
  it { is_expected.to have_many(:messages).dependent(:destroy) }

  it { is_expected.to validate_presence_of :subject }
end
