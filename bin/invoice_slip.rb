require_relative '../lib/invoice'

def get_file_as_string(filename)
  f = File.open(filename, "r")
  f.read
end

invoice = Invoice.from(get_file_as_string(ARGV[0]))

puts invoice.slip
