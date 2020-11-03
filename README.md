## +SUBSCRIBE Code Challenge

### Usage

To generate a invoice slip from a given input text file, run:
```shell script
ruby bin/invoice_slip.rb input/input1.txt
```

Or run the spec files with:
```shell script
rake test
```

### Changes

I took the liberty of correcting the Output 3 text:
```
1 imported bottle of perfume: 32.19
1 bottle of perfume: 20.89
1 packet of headache pills: 9.75
-3 imported box of chocolates: 35.55
+3 imported boxes of chocolates: 35.55
Sales Taxes: 7.90
Total: 98.38
```
