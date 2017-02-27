require 'rails_helper'

describe MessagesController do
  describe 'POST #create' do
    context 'successful' do
      let!(:ticket) { create :ticket, :without_validations, url_token: 'AAA123' }
      before { post :create, params: { ticket_url_token: 'AAA123', message: { body: 'Create new message' } } }

      it { expect(respond_with(ticket)) }
    end
  end
end
