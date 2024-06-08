# == Schema Information
#
# Table name: tradelines
#
#  id         :integer          not null, primary key
#  amount     :decimal(8, 2)
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Tradeline < ApplicationRecord
  # Associations
  has_many :deposits, dependent: :destroy

end
