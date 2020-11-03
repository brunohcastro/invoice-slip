class LineItem

  ITEM_TEMPLATE = /\A(?<quantity>\S+) (?<description>.+) at (?<value>\S+)\z/.freeze
  DEFAULT_TAX = 0.0

  attr_reader :value, :description, :quantity

  def initialize(quantity, description, value, taxes = DEFAULT_TAX)
    @quantity = quantity.to_i
    @description = description
    @value = value.to_f
    @taxes = taxes
  end

  def self.from(item, calculator)
    match = item.match(ITEM_TEMPLATE)

    return nil if match.nil?

    params = match.named_captures

    quantity = params['quantity'].to_i
    value = params['value'].to_f

    LineItem.new(
      quantity,
      params['description'],
      value,
      calculator.calculate(params['description'], value)
    )
  end

  def taxes
    @quantity * @taxes
  end

  def total
    (@quantity * @value) + taxes
  end
end
