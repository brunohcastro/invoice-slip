require '../lib/invoice'

describe Invoice do
  it "generate the invoice with line items for input" do
    invoice = Invoice.from("2 book at 12.49\n1 music CD at 14.99\n1 chocolate bar at 0.85")

    expect(invoice.line_items.size).to eq(3)
  end

  it "should indicate imported items" do
    invoice = Invoice.from("1 imported bottle of perfume at 27.99\n1 bottle of perfume at 18.99\n1 packet of headache pills at 9.75\n3 imported boxes of chocolates at 11.25")

    expect(invoice.has_imported_items).to eq(true)
  end

  it "should indicate no imported items" do
    invoice = Invoice.from("2 book at 12.49\n1 music CD at 14.99\n1 chocolate bar at 0.85")

    expect(invoice.has_imported_items).to eq(false)
  end

  it "should calculate totals" do
    invoice = Invoice.from("2 books at 12.49\n1 packet of headache pills at 9.75")

    expect(invoice.total).to eq(34.73)
  end
end