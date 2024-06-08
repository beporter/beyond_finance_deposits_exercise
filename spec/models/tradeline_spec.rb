require 'rails_helper'

RSpec.describe Tradeline, type: :model do
  describe 'associations' do
    it { should have_many(:deposits).class_name('Deposit') }
  end

  describe 'virtual fields' do
    it 'calculates amount from amount_cents' do
      t = build(:tradeline, amount_cents: 123456)

      expect(t.amount).to eq(1234.56)
    end
  end

end
