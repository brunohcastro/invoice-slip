class DefaultTaxCalculator

  PRECISION_IN_CENTS = 5
  IMPORTED_DESCRIPTOR = 'imported'.freeze
  IMPORT_DUTY = 0.05
  TAX_VALUE = 0.10
  TAX_FREE_ITEMS = %w[chocolate book pills].freeze

  def initialize(import_duty = IMPORT_DUTY, tax_value = TAX_VALUE, tax_free_items = TAX_FREE_ITEMS)
    @import_duty = import_duty
    @tax_value = tax_value
    @tax_free_items = tax_free_items
  end

  def calculate(description, price)
    tax = [
      tax_free?(description) ? @tax_value : 0,
      imported?(description) ? @import_duty : 0
    ].sum

    round(tax * (price * 100)).to_f / 100
  end

  def imported?(description)
    description.split.first == IMPORTED_DESCRIPTOR
  end

  def tax_free?(description)
    @tax_free_items.all? { |item| !description.include? item }
  end

  def round(value)
    return value if (value % 5).zero?

    ((value / PRECISION_IN_CENTS).floor * PRECISION_IN_CENTS) + PRECISION_IN_CENTS
  end
end