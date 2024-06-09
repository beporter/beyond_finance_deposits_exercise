require 'rails_helper'

RSpec.describe DepositsController, type: :controller do
  describe '#show' do
    let(:deposit) { FactoryBot.create :deposit }

    it 'responds with a 200' do
      get :show, params: { id: deposit.id }
      expect(response).to have_http_status(:ok)
    end

    context 'if the deposit is not found' do
      it 'responds with a 404' do
        get :show, params: { id: 0 }
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
