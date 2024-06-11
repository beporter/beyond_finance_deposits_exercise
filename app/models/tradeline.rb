class Tradeline < ApplicationRecord
  # Associations
  has_many :deposits, dependent: :destroy
  has_many :past_deposits, -> { where('deposit_date <= ?', Date.today) }, class_name: 'Deposit'


  # Virtual fields

  # FIXME: Remove this legacy coverage for anything that still uses the decimal value.
  def amount
    (amount_cents / 100.0).round(2)
  end

  def balance_cents
    # TODO: Consider caching this value if it gets expensive to compute.
    deposits_cents = if deposits.size > 0
      deposits.sum do |d|
        d.deposit_date <= Date.today ? d.amount_cents : 0
      end || 0
    else
      past_deposits.sum(:amount_cents) || 0
    end

    amount_cents - deposits_cents
  end

end

# == Schema Information
#
# Table name: tradelines
#
#  id           :integer          not null, primary key
#  amount_cents :integer
#  name         :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
