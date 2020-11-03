class LineItem

  def initialize(quantity, description, value)
    @quantity = quantity.to_i
    @description = description
    @value = value.to_f
    @imported = description.split.first == 'imported'
  end

  attr_reader :imported, :value, :description, :quantity

  def total
    @value * @quantity
  end

end
