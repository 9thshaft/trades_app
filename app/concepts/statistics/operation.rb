module Statistics
  class Operation
    class Collect < Trailblazer::Operation
      class Filter < Dry::Struct
        include Dry::Struct::Setters

        attribute? :trade_date_start, Types::Params::Nil | Types::Params::Date.optional
        attribute? :trade_date_end, Types::Params::Nil | Types::Params::Date.optional

        def run
          scope = Trade
          scope = scope.where('trade_date >= ?', trade_date_start) if trade_date_start.present?
          scope = scope.where('trade_date <= ?', trade_date_end) if trade_date_end.present?
          purchases_scope = scope.where(transaction_type: 'P')
          sales_scope = scope.where(transaction_type: 'S')
          dealer_scope = scope.where(transaction_type: 'D')

          [
            Metric.new('Total trades', scope.count, :qtt),
            Metric.new('Total purchases from customer', purchases_scope.count, :qtt),
            Metric.new('Total sells to customer', sales_scope.count, :qtt),
            Metric.new('Total dealer to dealer', dealer_scope.count, :qtt),
            Metric.new('Total trade price sum', scope.pluck(:trade_price).sum, :usd),
            Metric.new('Total purchases from customer sum', purchases_scope.pluck(:trade_price).sum, :usd),
            Metric.new('Total sells to customer sum', sales_scope.pluck(:trade_price).sum, :usd),
            Metric.new('Total dealer to dealer sum', dealer_scope.pluck(:trade_price).sum, :usd)
          ]
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

        property :trade_date_start, multi_params: true
        property :trade_date_end, multi_params: true
      end

      def process(params)
        validate(params) do
          contract.sync
        end
      end
    end
  end
end
