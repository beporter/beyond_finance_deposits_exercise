class Deposit < ApplicationRecord
  # Associations
  belongs_to :tradeline

  # Validations
  validates :amount_cents, numericality: { only_integer: true, greater_than: 0 }
  validates_date :deposit_date

end

# == Schema Information
#
# Table name: deposits
#
#  id           :integer          not null, primary key
#  amount_cents :integer          not null
#  deposit_date :date             not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  tradeline_id :integer          not null
#
# Indexes
#
#  index_deposits_on_tradeline_id  (tradeline_id)
#
# Foreign Keys
#
#  tradeline_id  (tradeline_id => tradelines.id)
#
