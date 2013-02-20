require 'simplecov'
SimpleCov.start
#require 'minitest/autorun'
require "sales_engine/customer"
require "time"
#require 'minitest/pride'
require_relative 'support'

module SalesEngine
  class CustomerTest < MiniTest::Unit::TestCase

  	def test_get_csv_loads_data
  		customer_file = "./test/sample/customers.csv"
  		file_contents = Customer.get_csv(customer_file)
  		assert_operator file_contents.size, :>= , 5
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
      assert_equal 3, customer.id
    end  

    def test_customer_find_by_created_at_returns_the_correct_created_at
      Customer.make_customers(true)#true for testing, false by default
      customer = Customer.find_by_created_at("2012-03-27 14:54:09 UTC")
      assert_equal Date.parse("2012-03-27 14:54:09 UTC"), customer.created_at
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
      customers = Customer.find_all_by_id(3)
      assert_equal 5, customers.count
    end  

    def test_customer_find_all_by_created_at_returns_the_correct_amount
      Customer.make_customers(true)#true for testing, false by default
      customers = Customer.find_all_by_created_at("2012-03-27 14:54:10 UTC")
      assert_equal 11, customers.count
    end

    def test_customer_find_all_by_updated_at_returns_the_correct_time
      Customer.make_customers(true)#true for testing, false by default
      customers = Customer.find_all_by_updated_at("2012-03-27 14:54:09 UTC")
      assert_equal 1, customers.count
    end  

    def test_invoices_instance_method_returns_correct_information
      Customer.make_customers
      Invoice.make_invoices
      customer = Customer.find_by_id(11)
      invoices = customer.invoices
      assert_equal 48, invoices[0].id
    end

    def test_transactions_returns_an_array
      Invoice.make_invoices
      Transaction.make_transactions
      Customer.make_customers
      customer = Customer.find_by_id(3)
      assert_kind_of Array, customer.transactions
    end

    def test_transactions_returns_an_array
      Invoice.make_invoices
      Transaction.make_transactions
      Customer.make_customers
      customer = Customer.find_by_id(2)
      assert_equal 1, customer.transactions.count
    end

    def test_favorite_merchant_returns_an_instance_of_merchant
      Invoice.make_invoices
      Merchant.make_merchants
      Customer.make_customers
      Transaction.make_transactions
      customer = Customer.find_by_id(2)
      assert_kind_of Merchant, customer.favorite_merchant
    end

    def test_favorite_merchant_returns_the_correct_instance
      Invoice.make_invoices
      Merchant.make_merchants
      Customer.make_customers
      Transaction.make_transactions
      customer = Customer.find_by_id(2)
      assert_equal "Shields, Hirthe and Smith", customer.favorite_merchant.name
    end
  end
end
