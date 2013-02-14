require 'minitest/autorun'
require "./lib/customer"
require "time"

class CustomerTest < MiniTest::Unit::TestCase
	def test_it_exists
		customer = Customer.new({})
		assert_kind_of Customer, customer
	end

	def test_get_csv_loads_data
		customer_file = "./test/sample/customers.csv"
		file_contents = Customer.get_csv(customer_file)
		assert_operator file_contents.size, :>= , 5
	end

	def test_customer_has_id
		customer = Customer.new({id: 4})
		assert_equal 4, customer.id
	end

	def test_customer_has_first_name
		customer = Customer.new({first_name: "Jimmy"})
		assert_equal "Jimmy", customer.first_name
	end

	def test_customer_has_last_name
		customer = Customer.new({:last_name => "Wales"})
		assert_equal "Wales", customer.last_name
	end

	def test_customer_has_created_at_time
		time_obj = Time.now
		customer = Customer.new({created_at: time_obj})
		assert_equal time_obj, customer.created_at
	end

	def test_customer_has_upadated_at_time
		time_obj = Time.now
		customer = Customer.new({updated_at: time_obj})
		assert_equal time_obj, customer.updated_at
	end

	def test_can_create_an_array_of_customers_from_sample_customers_csv
		Customer.make_customers(true)#true for testing
    @list_of_customers = Customer.list_of_customers 
		assert_equal Array, @list_of_customers.class
	end

  def test_can_create_a_customer_instance_from_sample_customers_csv
    Customer.make_customers(true)#true for testing, false by default
    @list_of_customers = Customer.list_of_customers
    assert_kind_of Customer, @list_of_customers[0]
  end

  def test_can_create_a_customer_with_the_right_name
    Customer.make_customers(true)#true for testing, false by default
    @list_of_customers = Customer.list_of_customers
    assert_equal "Joey", @list_of_customers[0].first_name
  end
end

#id,first_name,last_name,created_at,updated_at














