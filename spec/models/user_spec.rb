require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to have_many :tickets }
  it { is_expected.to define_enum_for(:role).with([:manager, :admin]) }
end
