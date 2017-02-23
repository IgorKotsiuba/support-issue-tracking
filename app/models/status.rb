# == Schema Information
#
# Table name: statuses
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Status < ApplicationRecord
  has_many :tickets

  validates :name, presence: true, uniqueness: true
end
