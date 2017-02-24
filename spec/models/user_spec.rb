require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to define_enum_for(:role).with([:customer, :manager, :admin]) }
end
