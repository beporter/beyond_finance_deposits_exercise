class Tradeline < ApplicationRecord
  # Associations
  has_many :deposits, dependent: :destroy

  # Virtual fields

  # FIXME: Remove this legacy coverage for anything that still uses the decimal value.
  def amount
    (amount_cents / 100.0).round(2)
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
