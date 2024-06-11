class CreateDeposits < ActiveRecord::Migration[7.1]
  def change
    create_table :deposits do |t|
      t.references :tradeline, null: false, foreign_key: true
      t.integer :amount_cents, null: false
      t.date :deposit_date, null: false

      t.timestamps
    end
  end
end
