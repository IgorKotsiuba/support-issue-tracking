# == Schema Information
#
# Table name: statuses
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Status, type: :model do
  it { is_expected.to have_many(:tickets) }

  it { is_expected.to validate_presence_of :name }

  describe 'validations'  do
    subject { FactoryGirl.build(:status) }
    it { is_expected.to validate_uniqueness_of :name }
  end
end
