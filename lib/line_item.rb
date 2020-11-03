class LineItem

  ITEM_TEMPLATE = /\A(?<quantity>\S+) (?<description>.+) at (?<value>\S+)\z/.freeze
  DEFAULT_TAX = 0.0

  attr_reader :value, :description, :quantity
  attr_writer :tax

  def initialize(quantity, description, value, tax = DEFAULT_TAX)
    @quantity = quantity.to_i
    @description = description
    @value = value.to_f
    @tax = tax
  end

  def self.from(item, calculator)
    match = item.match(ITEM_TEMPLATE)

    return nil if match.nil?

    params = match.named_captures

    LineItem.new(
      params['quantity'],
      params['description'],
      params['value'],
      calculator.calculate(params['description'])
    )
  end

  def taxes
    (@value * @quantity * @tax).round(2)
  end

  def total
    (@value * @quantity * (1 + @tax)).round(2)
  end
end
