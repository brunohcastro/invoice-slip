require_relative '../lib/invoice'

def get_file_as_string(filename)
  data = ''
  f = File.open(filename, "r")
  f.each_line do |line|
    data += line
  end

  data
end

invoice = Invoice.from(get_file_as_string(ARGV[0]))

puts invoice.slip
