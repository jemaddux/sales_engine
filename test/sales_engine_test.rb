#require 'simplecov'
#SimpleCov.start
#require 'minitest/autorun'
require "sales_engine"
#require 'minitest/pride'
require_relative 'support'

module SalesEngine
  class SalesEngineTest < MiniTest::Unit::TestCase

    def test_sales_engine_startup_for_customer
      SalesEngine.startup
      customer = Customer.list_of_customers[3]
      assert_kind_of Customer, customer
    end

    def test_sales_engine_startup_for_item
      SalesEngine.startup
      item = Item.list_of_items[3]
      assert_kind_of Item, item
    end

    def test_sales_engine_startup_for_merchant
      SalesEngine.startup
      merchant = Merchant.list_of_merchants[3]
      assert_kind_of Merchant, merchant
    end

    def test_sales_engine_startup_for_invoice
      SalesEngine.startup
      invoice = Invoice.list_of_invoices[3]
      assert_kind_of Invoice, invoice
    end
  end
end
