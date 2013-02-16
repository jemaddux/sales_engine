require 'simplecov'
SimpleCov.start
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

  def test_that_calling_invoices_on_an_instance_of_customer_returns_an_array
    Customer.make_customers(true)#true for using tesing data, false by default
    customer = Customer.list_of_customers[2]
    assert_equal Array, customer.invoices.class
  end

########################

  def test_Customer_responds_to_find_by_id
    assert Customer.respond_to?(:find_by_id) 
  end

  def test_Customer_responds_to_find_by_first_name
    assert Customer.respond_to?(:find_by_first_name)
  end

  def test_Customer_responds_to_find_by_last_name
    assert Customer.respond_to?(:find_by_last_name)
  end

  def test_Customer_responds_to_find_by_created_at
    assert Customer.respond_to?(:find_by_created_at)
  end

  def test_Customer_responds_to_find_by_updated_at
    assert Customer.respond_to?(:find_by_updated_at)
  end

  def test_Customer_responds_to_find_by_invoices
    assert Customer.respond_to?(:find_by_invoices)
  end

  def test_Customer_responds_to_find_all_by_id
    assert Customer.respond_to?(:find_all_by_id)
  end

  def test_Customer_responds_to_find_all_by_first_name
    assert Customer.respond_to?(:find_all_by_first_name)
  end

  def test_Customer_responds_to_find_all_by_created_at
    assert Customer.respond_to?(:find_all_by_created_at)
  end

  def test_Customer_responds_to_find_all_by_updated_at
    assert Customer.respond_to?(:find_all_by_updated_at)
  end

  def test_Customer_responds_to_find_all_by_last_name
    assert Customer.respond_to?(:find_all_by_last_name)
  end

  def test_Customer_responds_to_find_all_by_invoices
    assert Customer.respond_to?(:find_all_by_invoices)
  end

  def test_self_data_method_returns
    list = Customer.list_of_customers
    assert_equal list, Customer.data
  end

#######################################

  def test_customer_find_by_first_name_returns_the_correct_name
    Customer.make_customers(true)#true for testing, false by default
    customer = Customer.find_by_first_name("Joey")
    assert_equal "Joey", customer.first_name
  end

  def test_customer_find_by_last_name_returns_the_correct_name
    Customer.make_customers(true)#true for testing, false by default
    customer = Customer.find_by_last_name("Toy")
    assert_equal "Toy", customer.last_name
  end  

  def test_customer_find_by_id_returns_the_correct_id
    Customer.make_customers(true)#true for testing, false by default
    customer = Customer.find_by_id("3")
    assert_equal "3", customer.id
  end  

  def test_customer_find_by_created_at_returns_the_correct_created_at
    Customer.make_customers(true)#true for testing, false by default
    customer = Customer.find_by_created_at("2012-03-27 14:54:09 UTC")
    assert_equal "2012-03-27 14:54:09 UTC", customer.created_at
  end

  def test_customer_find_by_updated_at_returns_the_correct_time
    Customer.make_customers(true)#true for testing, false by default
    customer = Customer.find_by_updated_at("2012-03-27 14:54:09 UTC")
    assert_equal "2012-03-27 14:54:09 UTC", customer.updated_at
  end  

############################################

  def test_customer_find_all_by_first_name_returns_the_amount
    Customer.make_customers(true)#true for testing, false by default
    customers = Customer.find_all_by_first_name("Mariah")
    assert_equal 5, customers.count
  end

  def test_customer_find_all_by_last_name_returns_the_count
    Customer.make_customers(true)#true for testing, false by default
    customers = Customer.find_all_by_last_name("Toy")
    assert_equal 5, customers.count
  end  

  def test_customer_find_all_by_id_returns_the_count
    Customer.make_customers(true)#true for testing, false by default
    customers = Customer.find_all_by_id("3")
    assert_equal 5, customers.count
  end  

  def test_customer_find_all_by_created_at_returns_the_correct_amount
    Customer.make_customers(true)#true for testing, false by default
    customers = Customer.find_all_by_created_at("2012-03-27 14:54:10 UTC")
    assert_equal 10, customers.count
  end

  def test_customer_find_all_by_updated_at_returns_the_correct_time
    Customer.make_customers(true)#true for testing, false by default
    customers = Customer.find_all_by_updated_at("2012-03-27 14:54:09 UTC")
    assert_equal 1, customers.count
  end  

end

#:first_name, :last_name, :id, :created_at, :updated_at














