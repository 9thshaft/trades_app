module TradeSearch
  class Operation
    class Search < Trailblazer::Operation
      class Filter < Dry::Struct
        include Dry::Struct::Setters

        attribute? :trade_datetime_start, Types::Params::Nil | Types::Params::DateTime.optional
        attribute? :trade_datetime_end, Types::Params::Nil | Types::Params::DateTime.optional
        attribute? :maturity_date_start, Types::Params::Nil | Types::Params::Date.optional
        attribute? :maturity_date_end, Types::Params::Nil | Types::Params::Date.optional
        attribute? :transaction_types, Types::Array.optional
        attribute? :trade_price_start, Types::String.optional
        attribute? :trade_price_end, Types::String.optional

        def run
          scope = ::Trade
          scope = scope.where(transaction_type: transaction_types) if transaction_types.present? && (transaction_types - Trade::TRANSACTION_TYPES).blank?
          scope = scope.where('maturity_date >= ?', maturity_date_start) if maturity_date_start.present?
          scope = scope.where('maturity_date <= ?', maturity_date_end) if maturity_date_end.present?
          scope = scope.where('trade_datetime >= ?', trade_datetime_start) if trade_datetime_start.present?
          scope = scope.where('trade_datetime <= ?', trade_datetime_end) if trade_datetime_end.present?
          scope = scope.where('trade_price >= ?', trade_price_start) if trade_price_start.present?
          scope = scope.where('trade_price <= ?', trade_price_end) if trade_price_end.present?

          scope
        end

        def persisted?
          false
        end

        def to_s
          attributes.reject { |_, v| v.blank? }.map { |k, v| [k.to_s.humanize, v].join(': ') }.join(', ').presence.to_s
        end
      end

      include Model
      model Filter, :create

      contract do
        feature Reform::Form::MultiParameterAttributes

        property :trade_datetime_start, multi_params: true
        property :trade_datetime_end, multi_params: true
        property :maturity_date_start, multi_params: true
        property :maturity_date_end, multi_params: true
        property :transaction_types
        property :trade_price_start
        property :trade_price_end
      end

      def process(params)
        validate(params) do
          contract.sync
        end
      end
    end
  end
end
