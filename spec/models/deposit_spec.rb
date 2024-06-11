require 'rails_helper'

RSpec.describe Deposit, type: :model do
  describe 'columns' do
    it { should have_db_column(:amount_cents).of_type(:integer).with_options(null: false) }
    it { should have_db_column(:deposit_date).of_type(:date).with_options(null: false) }
  end

  describe 'indicies' do
    it { should have_db_index :tradeline_id }
  end

  describe 'associations' do
    it { should belong_to(:tradeline).class_name('Tradeline') }
  end

  describe 'validations' do
    it do
      should validate_numericality_of(:amount_cents)
        .only_integer
        .is_greater_than(0)
    end

    it 'rejects amounts exceeding parent Tradeline balance' do
      deposit = build(:deposit,
        amount_cents: 300_00,
        tradeline: build(:tradeline_with_deposits,
          amount_cents: 10_00,
          deposits_cents: [5_00],
        )
      )
      expect(deposit.valid?).to be_falsey
      expect(deposit.errors).to be_present
      expect(deposit.errors[:amount_cents].join(' ')).to include('Deposit amount exceeds Tradeline balance')
    end
  end
end
