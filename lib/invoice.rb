# frozen_string_literal: true

require '../lib/line_item'
require '../lib/tax_calculator'

class Invoice

  def initialize
    super
    @line_items = []
  end

  def self.from(input)
    invoice = Invoice.new

    items = input.split("\n")

    items.each do |item|
      item_template = /\A(?<amount>\S+) (?<description>.+) at (?<price>\S+)\z/

      match = item.match(item_template)

      next if match.nil?

      line_item = match.named_captures

      invoice.add_item(LineItem.new(line_item["amount"], line_item["description"], line_item["price"]))
    end

    invoice.apply_taxes

    invoice
  end

  attr_reader :line_items

  def apply_taxes
    calculator = TaxCalculator.new

    @line_items.each do |item|
      calculator.calculate(item)
    end
  end

  def add_item(item)
    @line_items.push(item)
  end

  def has_imported_items
    @line_items.any?(&:imported)
  end

  def total
    @line_items.reduce(0) { |sum, item| sum + item.total }.round(2)
  end

  def sales_taxes
    @line_items.reduce(0) { |sum, item| sum + item.taxes }.round(2)
  end

  def slip
    ""
  end
end
