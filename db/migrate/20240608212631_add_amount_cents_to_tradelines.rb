class AddAmountCentsToTradelines < ActiveRecord::Migration[7.1]
  def up
    add_column :tradelines, :amount_cents, :integer, null: false

    Tradeline.update_all('amount_cents = ROUND(amount * 100, 0)')
  end

  def down
    remove_column :tradelines, :amount_cents
  end
end
