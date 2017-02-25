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
#
# Indexes
#
#  index_tickets_on_customer_email    (customer_email) UNIQUE
#  index_tickets_on_reference_number  (reference_number) UNIQUE
#

require 'rails_helper'

RSpec.describe Ticket, type: :model do
  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:status) }
  it { is_expected.to have_many(:messages).dependent(:destroy) }

  it { is_expected.to validate_presence_of :subject }
  it { is_expected.to validate_presence_of :customer_name }
  it { is_expected.to validate_presence_of :customer_email }

  describe 'validations'  do
    subject { FactoryGirl.build(:ticket) }
    it { is_expected.to validate_uniqueness_of :customer_email }
  end
end
