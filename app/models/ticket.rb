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

class Ticket < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :status

  has_many :messages, dependent: :destroy

  validates :subject,        presence: true
  validates :customer_name,  presence: true
  validates :customer_email, presence: true, uniqueness: true

  after_validation :set_reference_token, on: :create

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
