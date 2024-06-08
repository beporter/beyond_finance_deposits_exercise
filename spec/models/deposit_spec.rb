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
    it { should validate_numericality_of(:amount_cents).only_integer.is_greater_than(0) }
  end
end
