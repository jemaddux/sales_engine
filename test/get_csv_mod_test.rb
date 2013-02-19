require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require "./lib/get_csv_mod"
require 'csv'
require 'minitest/pride'
require './lib/invoice'

class GetCSVTest < MiniTest::Unit::TestCase
	def test_customer_csv_file_exists
		customer_file = "./test/sample/customers.csv"
		assert File.exists?(customer_file), true
	end

	def test_customer_csv_file_has_data
		customer_file = "./test/sample/customers.csv"
		some_file = CSV.read(customer_file)
		assert_operator some_file.size, :>= , 5
	end

	def test_get_csv_returns_an_array
		invoice_file = "./test/sample/invoices.csv"
		file_contents = Invoice.get_csv(invoice_file)
		assert_equal Array, file_contents.class
	end

	def test_get_csv_first_object_in_array_is_a_hash
		merchant_file = "./test/sample/merchants.csv"
		file_contents = Merchant.get_csv(merchant_file) 
		assert_equal Hash, file_contents[2].class
	end

	def test_get_merchant_csv_returns_correct_name 
		merchant_file = "./test/sample/merchants.csv"
		file_contents = Merchant.get_csv(merchant_file)
		assert_equal "Bernhard-Johns", file_contents[6][:name]
	end
end

