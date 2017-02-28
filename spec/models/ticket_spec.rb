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

require 'rails_helper'

RSpec.describe Ticket, type: :model do
  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:status) }
  it { is_expected.to have_many(:messages).dependent(:destroy) }

  it { is_expected.to validate_presence_of :subject }
  it { is_expected.to validate_presence_of :customer_name }
  it { is_expected.to validate_presence_of :customer_email }

  describe '::with_status' do
    let!(:status1) { create :status, name: 'Waiting for Staff Response' }
    let!(:status2) { create :status, name: 'On Hold' }
    let!(:ticket1) { create :ticket, :without_validations, status: status1, reference_number: 'A1' }
    let!(:ticket2) { create :ticket, :without_validations, status: status1, reference_number: 'A2' }
    let!(:ticket3) { create :ticket, :without_validations, status: status2, reference_number: 'B1' }

    specify do
      expect(described_class.with_status('Invalid')).to  contain_exactly(ticket1, ticket2, ticket3)
      expect(described_class.with_status('On Hold')).to  contain_exactly(ticket3)
    end
  end

  describe '::with_reference_number' do
    let!(:status1) { create :status, name: 'Waiting for Staff Response' }
    let!(:status2) { create :status, name: 'On Hold' }
    let!(:ticket1) { create :ticket, :without_validations, status: status1, reference_number: 'A1' }
    let!(:ticket2) { create :ticket, :without_validations, status: status1, reference_number: 'A2' }
    let!(:ticket3) { create :ticket, :without_validations, status: status2, reference_number: 'B1' }

    specify do
      expect(described_class.with_reference_number('Invalid')).to be_empty
      expect(described_class.with_reference_number('A1')).to contain_exactly(ticket1)
      expect(described_class.with_reference_number('B1')).to contain_exactly(ticket3)
    end
  end

  describe '::with_subject' do
    let!(:status1) { create :status, name: 'Waiting for Staff Response' }
    let!(:status2) { create :status, name: 'On Hold' }
    let!(:ticket1) { create :ticket, :without_validations, status: status1, subject: 'A1 S' }
    let!(:ticket2) { create :ticket, :without_validations, status: status1, subject: 'A2' }
    let!(:ticket3) { create :ticket, :without_validations, status: status2, subject: 'B1' }

    specify do
      expect(described_class.with_subject('Invalid')).to be_empty
      expect(described_class.with_subject('A')).to contain_exactly(ticket1, ticket2)
      expect(described_class.with_subject('B1')).to contain_exactly(ticket3)
    end
  end

  describe '::search_by_params' do
    let(:ticket_with_status)           { double :ticket_with_status }
    let(:ticket_with_reference_number) { double :ticket_with_reference_number }
    let(:ticket_with_subject)          { double :ticket_with_subject }
    let(:params) do
      { status: double(:status), reference_number: double(:reference_number), subject: double(:subject) }
    end

    before do
      allow(described_class).to receive(:with_status) { ticket_with_status }
      allow(ticket_with_status).to receive(:with_reference_number) { ticket_with_reference_number }
      allow(ticket_with_reference_number).to receive(:with_subject) { ticket_with_subject }
    end

    it {expect(described_class.search_by_params(params)).to eq  ticket_with_subject}
  end
end
