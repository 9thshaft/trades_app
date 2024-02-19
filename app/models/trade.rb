# frozen_string_literal: true

class Trade < ApplicationRecord
  # P - Purchase From Customer
  # S - Sell to Customer
  # D - Dealer to Dealer
  TRANSACTION_TYPES = %w[P S D].freeze

  self.primary_key = :row_id

  validates :transaction_type, inclusion: { in: TRANSACTION_TYPES }
  validates :trade_date, :trade_datetime, :security_id, :security_name,
            :coupon_rate, :trade_price, :par_traded, :notional_amount,
            presence: true
end
