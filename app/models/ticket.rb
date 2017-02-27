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
#  index_tickets_on_customer_email    (customer_email) UNIQUE
#  index_tickets_on_reference_number  (reference_number) UNIQUE
#  index_tickets_on_url_token         (url_token) UNIQUE
#

class Ticket < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :status

  has_many :messages, dependent: :destroy

  validates :subject,        presence: true
  validates :customer_name,  presence: true
  validates :customer_email, presence: true, uniqueness: true

  after_validation :set_reference_token, on: :create
  after_validation :set_url_token,       on: :create

  def to_param
    url_token
  end

  private

  def set_reference_token
    self.reference_number = generate_reference_token
  end

  def set_url_token
    self.url_token = generate_url_token
  end

  def generate_reference_token
    loop do
      token = "#{('A'..'Z').to_a.sample(3).join}-#{SecureRandom.hex(1)}-#{('A'..'Z').to_a.sample(3).join}-" \
              "#{SecureRandom.hex(1)}-#{('A'..'Z').to_a.sample(3).join}"
      break token unless Ticket.where(reference_number: token).exists?
    end
  end

  def generate_url_token
    loop do
      token = SecureRandom.urlsafe_base64(30, false)
      break token unless Ticket.where(url_token: token).exists?
    end
  end
end
