class RemoveAmountFromTradelines < ActiveRecord::Migration[7.1]
  def up
    remove_column :tradelines, :amount
  end

  def down
    add_column :tradelines, :amount, :decimal, precision: 8, scale: 2

    # Possible loss of precision here.
    Tradeline.update_all('amount = ROUND(amount_cents / 100, 2)')
  end
end
