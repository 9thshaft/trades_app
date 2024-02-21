class Metric < Struct.new(:name, :value, :units)
  include ActionView::Helpers::NumberHelper

  def value_with_unit
    case units
    when :qtt
      number_with_delimiter(value)
    when :usd
      number_to_currency(value)
    else
      value
    end
  end
end
