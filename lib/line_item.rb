class LineItem

  def initialize(quantity, description, value)
    @quantity = quantity.to_i
    @description = description
    @value = value.to_f
    @imported = description.split.first == 'imported'
    @tax = 0.0
  end

  attr_reader :imported, :value, :description, :quantity
  attr_writer :tax

  def taxes
    (@value * @quantity * @tax).round(2)
  end

  def total
    (@value * @quantity * (1 + @tax)).round(2)
  end
end
