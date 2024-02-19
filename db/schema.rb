# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_02_19_221424) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "hstore"
  enable_extension "plpgsql"

  create_table "trades", id: false, force: :cascade do |t|
    t.bigint "row_id", null: false
    t.date "trade_date"
    t.datetime "trade_datetime", precision: nil
    t.bigint "security_id"
    t.text "security_name"
    t.decimal "coupon_rate", precision: 10, scale: 6
    t.date "maturity_date"
    t.string "transaction_type"
    t.decimal "trade_price", precision: 10, scale: 4
    t.decimal "trade_yield", precision: 10, scale: 6
    t.integer "par_traded"
    t.decimal "notional_amount", precision: 24, scale: 12
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["maturity_date"], name: "index_trades_on_maturity_date"
    t.index ["row_id"], name: "index_trades_on_row_id", unique: true
    t.index ["trade_datetime"], name: "index_trades_on_trade_datetime"
    t.index ["trade_price"], name: "index_trades_on_trade_price"
    t.index ["transaction_type"], name: "index_trades_on_transaction_type"
  end

end
