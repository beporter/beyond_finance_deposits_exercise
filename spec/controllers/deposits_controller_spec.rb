require 'rails_helper'

RSpec.describe DepositsController, type: :controller do
  describe '#index' do
    let(:tradeline) do
      create(:tradeline_with_deposits,
        amount_cents: 100_00,
        deposits_cents: [25_00, 15_00, 30_00],
      )
    end

    it 'responds with a 200' do
      get :index, params: { tradeline_id: tradeline.id }
      expect(response).to have_http_status(:ok)

      json = JSON.parse(response.body)

      returned_ids = json.pluck('id')
      expect(returned_ids).to eq(tradeline.deposits.pluck(:id))
    end
  end

  describe '#show' do
    let(:deposit) { create(:deposit, amount_cents: 1_00) }

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

  describe '#create' do
    let(:tradeline) { create(:tradeline, amount_cents: 500_00) }
    let(:json) { JSON.parse(response.body) }
    before do
      post(:create,
        params: {
          tradeline_id: tradeline.id,
          deposit: {
            amount_cents: deposit_amount,
            deposit_date: '2024-06-09',
          },
        },
        as: :json
      )
    end

    context 'success' do
      let(:deposit_amount) { 100_00 }

      it 'accepts a deposit below Tradeline balance' do
        expect(response).to have_http_status(:ok)
        expect(json).to include(
          'amount_cents' => deposit_amount,
          'tradeline_id' => tradeline.id,
        )
      end
    end

    context 'validation failures' do
      let(:deposit_amount) { 800_00 }

      it 'rejects a deposit above Tradeline balance' do
        expect(response).to have_http_status(:unprocessable_entity)
        expect(json['error']['details']['amount_cents']).to include(/Deposit amount exceeds Tradeline balance/)
      end
    end

    context 'tradeline not found' do
      let(:deposit_amount) { 9_00 }
      let(:tradeline) { build(:tradeline, id: -1) }

      it 'rejects a deposit for a non-existent Tradeline' do
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
