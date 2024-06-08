require 'rails_helper'

RSpec.describe Tradeline, type: :model do
  describe 'associations' do
    it { should have_many(:deposits).class_name('Deposit') }
  end
end
