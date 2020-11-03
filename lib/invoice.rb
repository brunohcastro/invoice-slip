require_relative 'line_item'
require_relative 'default_tax_calculator'

class Invoice

  attr_reader :line_items

  def initialize(line_items = [])
    @line_items = line_items
  end

  def self.from(input, calculator = DefaultTaxCalculator.new)
    Invoice.new(input.split("\n").map { |item| LineItem.from(item, calculator) })
  end

  def total
    @line_items.map(&:total).sum.round(2)
  end

  def sales_taxes
    @line_items.map(&:taxes).sum.round(2)
  end

  def slip
    [
      @line_items.map { |item| "#{item.quantity} #{item.description}: #{'%.2f' % item.total}" },
      "Sales Taxes: #{'%.2f' % sales_taxes}",
      "Total: #{'%.2f' % total}"
    ].join("\n")
  end
end
