require 'minitest/autorun'
require '../lib/invoice'

describe Invoice do
  it 'generate the invoice with line items for input' do
    invoice = Invoice.from("2 book at 12.49\n1 packet of headache pills at 9.75")

    _(invoice.line_items.size).must_equal 2

    _(invoice.line_items[0].quantity).must_equal 2
    _(invoice.line_items[0].description).must_equal 'book'
    _(invoice.line_items[0].value).must_equal 12.49
    _(invoice.line_items[0].total).must_equal 24.98

    _(invoice.line_items[1].quantity).must_equal 1
    _(invoice.line_items[1].description).must_equal 'packet of headache pills'
    _(invoice.line_items[1].value).must_equal 9.75
    _(invoice.line_items[1].total).must_equal 9.75
  end

  it 'should calculate totals' do
    invoice = Invoice.from("2 books at 12.49\n1 packet of headache pills at 9.75")

    _(invoice.total).must_equal 34.73
  end

  it 'should add sales tax' do
    invoice = Invoice.from('1 bottle of perfume at 18.99')

    _(invoice.total).must_equal 20.89
    _(invoice.sales_taxes).must_equal 1.9
  end

  it 'should add import tax' do
    invoice = Invoice.from('1 imported box of chocolates at 10.00')

    _(invoice.total).must_equal 10.50
    _(invoice.sales_taxes).must_equal 0.5
  end

  it 'should add import and sales taxes' do
    invoice = Invoice.from('1 imported bottle of perfume at 27.99')

    _(invoice.total).must_equal 32.19
    _(invoice.sales_taxes).must_equal 4.2
  end

  it 'should generate slip for scenario 1' do
    invoice = Invoice.from("2 book at 12.49\n1 music CD at 14.99\n1 chocolate bar at 0.85")

    _(invoice.slip).must_equal "2 book: 24.98\n1 music CD: 16.49\n1 chocolate bar: 0.85\nSales Taxes: 1.50\nTotal: 42.32"
  end

  it 'should generate slip for scenario 2' do
    invoice = Invoice.from("1 imported box of chocolates at 10.00\n1 imported bottle of perfume at 47.50")

    _(invoice.slip).must_equal "1 imported box of chocolates: 10.50\n1 imported bottle of perfume: 54.65\nSales Taxes: 7.65\nTotal: 65.15"
  end

  it 'should generate slip for scenario 3' do
    invoice = Invoice.from("1 imported bottle of perfume at 27.99\n1 bottle of perfume at 18.99\n1 packet of headache pills at 9.75\n3 imported boxes of chocolates at 11.25")

    _(invoice.slip).must_equal "1 imported bottle of perfume: 32.19\n1 bottle of perfume: 20.89\n1 packet of headache pills: 9.75\n3 imported boxes of chocolates: 35.55\nSales Taxes: 7.90\nTotal: 98.38"
  end
end