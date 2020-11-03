require '../lib/invoice'

describe Invoice do
  it "generate the invoice with line items for input" do
    invoice = Invoice.from("2 book at 12.49\n1 music CD at 14.99\n1 chocolate bar at 0.85")

    expect(invoice.line_items.size).to eq(3)
  end

  it "should indicate imported items" do

  end
end