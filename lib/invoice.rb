# frozen_string_literal: true

require '../lib/line_item'

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

      continue if match.nil?

      line_item = match.named_captures

      invoice.add_item(LineItem.new(line_item["amount"], line_item["description"], line_item["price"]))
    end

    invoice
  end

  attr_reader :line_items

  def add_item(item)
    @line_items.push(item)
  end

  def has_imported_items
    @line_items.any?(&:imported)
  end

  def slip
    ""
  end
end
