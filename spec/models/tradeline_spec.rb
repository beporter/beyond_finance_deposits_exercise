require 'rails_helper'

RSpec.describe Tradeline, type: :model do
  describe 'associations' do
    it { should have_many(:deposits).class_name('Deposit') }
  end

  describe 'virtual fields' do
    it 'calculates amount from amount_cents' do
      t = build(:tradeline, amount_cents: 1234_56)

      expect(t.amount).to eq(1234.56)
    end

    it 'pulls accurate balance_cents from associated in-memory deposits' do
      t = build(:tradeline,
        amount_cents: 1234_56,
        deposits: {
          1000_00 => Date.yesterday.to_s,
          200_00 => Date.today.to_s,
          56 => Date.tomorrow.to_s, # won't count towards balance!
        }.map do |cents, day|
          build(:deposit, tradeline: t, amount_cents: cents, deposit_date: day)
        end
      )

      expect(t.balance_cents).to eq(34_56)
    end

    it 'pulls accurate balance_cents from db deposits' do
      t = create(:tradeline_with_deposits,
        amount_cents: 2345_67,
        deposits_cents: [2000_00, 300_00, 67]
      )

      expect(t.balance_cents).to eq(45_00)
    end
  end
end
