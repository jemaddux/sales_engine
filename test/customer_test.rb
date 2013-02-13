require 'minitest/autorun'
require "./lib/customer"

class CustomerTest < MiniTest::Unit::TestCase
	def test_it_exists
		customer = Customer.new
		assert_kind_of Customer, customer
	end

	def test_get_csv_loads_data
		customer_file = "./test/sample/customers.csv"
		file_contents = Customer.get_csv(customer_file)
		assert_operator file_contents.size, :>= , 5
	end
end