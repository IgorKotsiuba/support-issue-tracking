require 'rails_helper'

describe Admin::TicketsController do
  let!(:user) { create :user }
  before      { sign_in user }

  context 'GET #show' do
    let!(:ticket1) { create :ticket, :without_validations, id: 1 }
    let!(:ticket2) { create :ticket, :without_validations, id: 2 }

    specify do
      get :show, params: { id: '1' }
      expect(assigns(:ticket)).to eq ticket1
    end
  end

  context 'GET #index' do
    let!(:status1) { create :status, name: 'Waiting for Staff Response' }
    let!(:status2) { create :status, name: 'Waiting for Customer' }
    let!(:ticket1) { create :ticket, :without_validations, status: status1 }
    let!(:ticket2) { create :ticket, :without_validations, status: status2 }

    let!(:params) { { ticket: {} } }

    specify do
      get :index, params: params

      expect(assigns(:tickets)).to contain_exactly(ticket2, ticket1)
    end
  end
end
