require '../lib/invoice'

describe Invoice do
  it 'generate the invoice with line items for input' do
    invoice = Invoice.from("2 book at 12.49\n1 packet of headache pills at 9.75")

    expect(invoice.line_items.size).to eq(2)

    expect(invoice.line_items[0].quantity).to eq(2)
    expect(invoice.line_items[0].description).to eq('book')
    expect(invoice.line_items[0].value).to eq(12.49)
    expect(invoice.line_items[0].total).to eq(24.98)

    expect(invoice.line_items[1].quantity).to eq(1)
    expect(invoice.line_items[1].description).to eq('packet of headache pills')
    expect(invoice.line_items[1].value).to eq(9.75)
    expect(invoice.line_items[1].total).to eq(9.75)
  end

  it 'should indicate imported items' do
    invoice = Invoice.from("1 imported bottle of perfume at 27.99\n1 bottle of perfume at 18.99\n1 packet of headache pills at 9.75\n3 imported boxes of chocolates at 11.25")

    expect(invoice.has_imported_items).to eq(true)
  end

  it 'should indicate no imported items' do
    invoice = Invoice.from("2 book at 12.49\n1 music CD at 14.99\n1 chocolate bar at 0.85")

    expect(invoice.has_imported_items).to eq(false)
  end

  it 'should calculate totals' do
    invoice = Invoice.from("2 books at 12.49\n1 packet of headache pills at 9.75")

    expect(invoice.total).to eq(34.73)
  end

  it 'should add sales tax' do
    invoice = Invoice.from('1 bottle of perfume at 18.99')

    expect(invoice.total).to eq(20.89)
    expect(invoice.sales_taxes).to eq(1.9)
  end

  it 'should add import tax' do
    invoice = Invoice.from('1 imported box of chocolates at 10.00')

    expect(invoice.total).to eq(10.50)
    expect(invoice.sales_taxes).to eq(0.5)
  end

  it 'should add import and sales taxes' do
    invoice = Invoice.from('1 imported bottle of perfume at 27.99')

    expect(invoice.total).to eq(32.19)
    expect(invoice.sales_taxes).to eq(4.2)
  end
end