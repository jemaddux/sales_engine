#require 'simplecov'
#SimpleCov.start
#require 'minitest/autorun'
require "sales_engine/invoice"
require "sales_engine/invoice_item"
#require 'minitest/pride'
require_relative 'support'

module SalesEngine
  class InvoiceTest < MiniTest::Unit::TestCase
  	def test_it_exists
  		invoice = Invoice.new({})
  		assert_kind_of Invoice, invoice
  	end

  	def test_get_csv_loads_data
  		invoice_file = "./test/sample/invoices.csv"
  		file_contents = Invoice.get_csv(invoice_file)
  		assert_operator file_contents.size, :>= , 5
  	end

    def test_that_we_can_get_an_invoice_id_from_an_instance
      invoice = Invoice.new(:id => "1")
      assert_equal "1", invoice.id
    end

    def test_that_we_can_get_an_invoice_customer_id_from_an_instance
      invoice = Invoice.new(:customer_id => "3")
      assert_equal "3", invoice.customer_id
    end

    def test_that_we_can_get_a_merchant_id_from_an_instance
      invoice = Invoice.new(:merchant_id => "25")
      assert_equal "25", invoice.merchant_id
    end

    def test_that_we_can_get_a_status_from_an_instance
      invoice = Invoice.new(:status => "shipped")
      assert_equal "shipped", invoice.status
    end

    def test_that_we_can_get_an_invoice_created_date_from_an_instance
      time = Time.now
      invoice = Invoice.new(:created_at => time)
      assert_equal time, invoice.created_at
    end

    def test_that_we_can_get_an_invoice_updated_date_from_an_instance
      time = Time.now
      invoice = Invoice.new(:updated_at => time)
      assert_equal time, invoice.updated_at
    end

    def test_that_we_can_create_invoice_objects_using_simulated_data
      single_invoice = {
        :id => "1",
        :customer_id => "3",
        :merchant_id => "25",
        :status => "shipped",
        :created_at => "2012-03-25 09:54:09 UTC",
        :updated_at => "2012-03-27 14:53:59 UTC"
      }
      assert_kind_of Invoice, Invoice.new(single_invoice)
    end

    def test_that_calling_new_invoices_returns_an_array
      invoice_list = Invoice.make_invoices(true)
      assert_equal Array, invoice_list.class
    end

    def test_that_invoice_has_a_random_method
      assert Invoice.respond_to?(:random)
    end

    def test_invoice_responds_to_find_by_id
      assert Invoice.respond_to?(:find_by_id) 
    end

    def test_invoice_responds_to_find_by_customer_id
      assert Invoice.respond_to?(:find_by_customer_id) 
    end

    def test_invoice_responds_to_find_by_merchant_id
      assert Invoice.respond_to?(:find_by_merchant_id) 
    end

    def test_invoice_responds_to_find_by_status
      assert Invoice.respond_to?(:find_by_status) 
    end

    def test_invoice_responds_to_find_by_created_at
      assert Invoice.respond_to?(:find_by_created_at) 
    end

    def test_invoice_responds_to_find_by_updated_at
      assert Invoice.respond_to?(:find_by_updated_at) 
    end

  ################################################

    def test_invoice_find_by_id_returns_the_correct_id
      Invoice.make_invoices(true)#true for testing, false by default
      invoice = Invoice.find_by_id("3")
      assert_equal "3", invoice.id
    end  

    def test_invoice_find_by_created_at_returns_the_correct_created_at
      Invoice.make_invoices(true)#true for testing, false by default
      invoice = Invoice.find_by_created_at("2012-03-09 01:54:10 UTC")
      assert_equal "2012-03-09 01:54:10 UTC", invoice.created_at
    end

    def test_invoice_find_by_updated_at_returns_the_correct_time
      Invoice.make_invoices(true)#true for testing, false by default
      invoice = Invoice.find_by_updated_at("2012-03-09 01:54:10 UTC")
      assert_equal "2012-03-09 01:54:10 UTC", invoice.updated_at
    end  

  ############################################

    def test_invoice_find_all_by_id_returns_the_count
      Invoice.make_invoices(true)#true for testing, false by default
      invoices = Invoice.find_all_by_id("3")
      assert_equal 2, invoices.count
    end  

    def test_invoice_find_all_by_created_at_returns_the_correct_amount
      Invoice.make_invoices(true)#true for testing, false by default
      invoices = Invoice.find_all_by_created_at("2012-03-09 01:54:10 UTC")
      assert_equal 5, invoices.count
    end

    def test_invoice_find_all_by_updated_at_returns_the_correct_time
      Invoice.make_invoices(true)#true for testing, false by default
      invoices = Invoice.find_all_by_updated_at("2012-03-09 01:54:10 UTC")
      assert_equal 5, invoices.count
    end    

  ######################################################

    def test_invoice_hash_transactions_returns_an_array
      Invoice.make_invoices(true)
      Transaction.make_transactions(true)
      invoice = Invoice.list_of_invoices[0]
      assert_equal Array, invoice.transactions.class
    end

    def test_invoice_hash_transactions_returns_the_right_instances
      Invoice.make_invoices(true)
      Transaction.make_transactions(true)
      invoice = Invoice.list_of_invoices[0]
      assert_equal Array, invoice.transactions.class
      assert_equal "1", invoice.transactions[0].id
      assert_equal "4654405418249632", invoice.transactions[0].credit_card_number
    end

    def test_invoice_hash_invoice_items_returns_an_array
      Invoice.make_invoices(true)
      InvoiceItem.make_invoice_items(true)
      invoice = Invoice.list_of_invoices[0]
      assert_equal Array, invoice.invoice_items.class
    end

    def test_invoice_hash_invoice_items_returns_the_right_instances
      Invoice.make_invoices(true)
      InvoiceItem.make_invoice_items(true)
      invoice = Invoice.list_of_invoices[0]
      assert_equal Array, invoice.invoice_items.class
      assert_equal "1", invoice.invoice_items[0].id
    end

    def test_invoice_hash_items_returns_an_array
      Invoice.make_invoices
      Item.make_items
      InvoiceItem.make_invoice_items
      invoice = Invoice.list_of_invoices[0]
      assert_equal Array, invoice.items.class
    end

    def test_invoice_hash_items_returns_the_right_instances
      Invoice.make_invoices
      Item.make_items
      InvoiceItem.make_invoice_items
      invoice = Invoice.list_of_invoices[0]
      assert_equal Array, invoice.items.class
      assert_equal "539", invoice.items[0].id
    end

    def test_invoice_hash_customer_returns_an_instance_of_the_customer_class
      Invoice.make_invoices
      Customer.make_customers
      invoice = Invoice.list_of_invoices[120]
      assert_equal Customer, invoice.customer.class
    end  

    def test_invoice_hash_customer_returns_the_right_instance_of_customer
      Invoice.make_invoices
      Customer.make_customers
      invoice = Invoice.list_of_invoices[75]
      customer = invoice.customer
      assert_equal "15", customer.id
    end

    def test_create_takes_a_hash_of_data_and_makes_new_objects
      Invoice.make_invoices
      Customer.make_customers
      Merchant.make_merchants
      Transaction.make_transactions
      customer = Customer.find_by_id("5")
      merchant = Merchant.find_by_id("5")
      item1 = Item.find_by_id("6")
      item2 = Item.find_by_id("7")
      item3 = Item.find_by_id("6")

      invoice = Invoice.create(customer: customer, merchant: merchant, status: "shipped", items: [item1, item2, item3])

      invoice.charge(credit_card_number: "4444333322221111", credit_card_expiration: "10/13", result: "success")
    end

  end
end
