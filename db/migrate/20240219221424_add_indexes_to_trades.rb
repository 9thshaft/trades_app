class AddIndexesToTrades < ActiveRecord::Migration[7.1]
  def change
    add_index :trades, :transaction_type
    add_index :trades, :trade_price
    add_index :trades, :maturity_date
    add_index :trades, :trade_datetime
  end
end
