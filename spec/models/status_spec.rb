require 'rails_helper'

RSpec.describe Status, type: :model do
  it { is_expected.to have_many(:tickets) }

  it { is_expected.to validate_presence_of :name }

  describe 'validations'  do
    subject { FactoryGirl.build(:status) }
    it { is_expected.to validate_uniqueness_of :name }
  end
end
