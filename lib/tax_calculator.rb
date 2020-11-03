class TaxCalculator
  def initialize
    super

    @import_duty = 0.05
    @tax_value = 0.10
    @tax_free_items = ['chocolate', 'book', 'pills']
  end

  def calculate(line_item)
    tax = 0.0

    if @tax_free_items.all? { |item| !line_item.description.include? item }
      tax += @tax_value
    end

    tax += @import_duty if line_item.imported

    line_item.tax = tax
  end
end