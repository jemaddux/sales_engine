require 'minitest/autorun'
require "./lib/invoice"

class InvoiceTest < MiniTest::Unit::TestCase
	def test_it_exists
		invoice = Invoice.new
		assert_kind_of Invoice, invoice
	end

	def test_get_csv_loads_data
		invoice_file = "./test/sample/invoices.csv"
		file_contents = Invoice.get_csv(invoice_file)
		assert_operator file_contents.size, :>= , 5
	end
end