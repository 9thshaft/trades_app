class CreateTrades < ActiveRecord::Migration[7.1]
  def change
    create_table :trades, id: false, primary_key: :row_id do |t|
      t.bigint :row_id, null: false
      t.date :trade_date
      t.timestamp :trade_datetime
      t.bigint :security_id
      t.text :security_name
      t.decimal :coupon_rate, precision: 10, scale: 6
      t.date :maturity_date
      t.string :transaction_type
      t.decimal :trade_price, precision: 10, scale: 4
      t.decimal :trade_yield, precision: 10, scale: 6
      t.integer :par_traded
      t.decimal :notional_amount, precision: 24, scale: 12

      t.timestamps

      t.index :row_id, unique: true
    end
  end
end
