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

class Ticket < ApplicationRecord
  belongs_to :customer, class_name: 'User'
  belongs_to :manager,  class_name: 'User', optional: true
  belongs_to :status

  has_many :messages, dependent: :destroy

  validates :subject,          presence: true
  validates :reference_number, presence: true, uniqueness: true

  before_validation :set_reference_token, on: :create

  private

  def set_reference_token
    self.reference_number = generate_token
  end

  def generate_token
    loop do
      token = "#{('A'..'Z').to_a.sample(3).join}-#{SecureRandom.hex(1)}-#{('A'..'Z').to_a.sample(3).join}-" \
              "#{SecureRandom.hex(1)}-#{('A'..'Z').to_a.sample(3).join}"
      break token unless Ticket.where(reference_number: token).exists?
    end
  end
end
