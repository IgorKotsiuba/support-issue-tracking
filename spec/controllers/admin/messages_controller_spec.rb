require 'rails_helper'

describe Admin::MessagesController do
  describe 'POST #create' do
    context 'successful' do
      let!(:status1) { create :status, name: 'On Hold', id: 1 }
      let!(:status2) { create :status, name: 'Canceled', id: 2 }
      let!(:user1)   { create :user, username: 'manager', id: 1 }
      let!(:user2)   { create :user, username: 'new_manager', id: 2 }
      let!(:ticket)  { create :ticket, :without_validations, id: 1, status: status1, user: user1 }
      let(:worker)   { double :worker }

      let(:params) do
        { ticket_id: '1', message: { body: 'Answer to customer', ticket: { user_id: user2.id, status_id: status2.id } } }
      end

      before do
        sign_in user1
        post :create, params: params
        allow(TicketResponseNotifierWorker).to receive(:perform_async) { worker }
      end

      specify do
        expect(response).to redirect_to admin_ticket_path(ticket.id)
        expect { post :create, params: params }.to change(Message, :count).by(1)

        Ticket.last.tap do |ticket|
          expect(ticket.user_id).to eq   2
          expect(ticket.status_id).to eq 2
        end
      end
    end
  end
end
