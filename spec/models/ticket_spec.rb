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
