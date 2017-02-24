require 'rails_helper'

RSpec.describe Ticket, type: :model do
  it { is_expected.to belong_to(:customer).class_name('User') }
  it { is_expected.to belong_to(:manager).class_name('User') }
  it { is_expected.to belong_to(:status) }
  it { is_expected.to have_many(:messages).dependent(:destroy) }

  it { is_expected.to validate_presence_of :subject }
end
