require 'rails_helper'

describe TicketsController do
  context 'GET #new' do
    let(:ticket) { build :ticket }

    specify do
      get :new
      expect(respond_with(ticket))
    end
  end

  context 'GET #show' do
    let!(:ticket1) { create :ticket, :without_validations, url_token: '123ABC' }
    let!(:ticket2) { create :ticket, :without_validations, url_token: '456DEF' }

    specify do
      get :show, params: { url_token: '123ABC' }
      expect(respond_with(ticket1))
    end
  end

  context 'GET #edit' do
    let!(:ticket1) { create :ticket, :without_validations }
    let!(:ticket2) { create :ticket, :without_validations, url_token: '456DEF' }

    specify do
      get :edit, params: { url_token: '456DEF' }
      expect(respond_with(ticket2))
    end
  end

  context 'PUT #update' do
    let!(:status1) { create :status, name: 'Waiting for Staff Response' }
    let!(:status2) { create :status, name: 'Waiting for Customer' }
    let!(:ticket) do
      create :ticket, :without_validations, customer_name: 'John Doe', customer_email: 'customer@ukr.net',
        url_token: '123ABC', status: status2
    end

    let!(:params) do
      { url_token: '123ABC',
        ticket: { customer_name: 'Ryan', customer_email: 'new_email@ukr.net', status_id: status2.id } }
    end

    specify do
      put :update, params: params

      expect(response).to redirect_to ticket_path(ticket)
      expect(respond_with(ticket))

      Ticket.last.tap do |ticket|
        expect(ticket.customer_name).to eq  'Ryan'
        expect(ticket.customer_email).to eq 'new_email@ukr.net'
        expect(ticket.status.name).to eq    'Waiting for Staff Response'
      end
    end
  end

  context 'POST #create' do
    let!(:status) { create :status, name: 'Waiting for Staff Response' }
    let!(:params) do
      { ticket:  { customer_name: 'John Doe', customer_email: 'email@ukr.net', subject: 'Broken phone',
        message: { body: 'Need help' } } }
    end
    let(:worker) { double :worker }

    before { allow(TicketCreationNotifierWorker).to receive(:perform_async) { worker } }

    specify 'successfull' do
      post :create, params: params
      expect(response).to redirect_to root_path
    end
  end
end
