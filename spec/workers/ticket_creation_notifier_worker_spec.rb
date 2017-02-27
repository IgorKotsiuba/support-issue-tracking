require 'rails_helper'

RSpec.describe TicketCreationNotifierWorker, type: :worker do
  let!(:ticket) { create :ticket, customer_email: 'test@example.com' }
  let(:worker)  { described_class.new }

  specify do
    expect(TicketMailer).to receive(:confirming_notification).with(ticket.id).and_call_original
    worker.perform(ticket.id)

    ActionMailer::Base.deliveries.last.tap do |mail|
      expect(mail).to be_present
      expect(mail.subject).to eq  'Ticket request confirmation'
      expect(mail.to.first).to eq 'test@example.com'
    end
  end
end
