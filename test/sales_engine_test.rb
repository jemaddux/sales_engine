require 'minitest/autorun'
require "./sales_engine"

class SalesEngineTest < MiniTest::Unit::TestCase
	def test_it_exists
		sales = SalesEngine.new
		assert_kind_of SalesEngine, sales
	end

  def test_sales_engine_startup_for_customer
    SalesEngine.startup
    list_of_customers = Customer.list_of_customers
    list_of_customers.each do |customer|
      assert_kind_of Customer, customer
    end
  end

  def test_sales_engine_startup_for_item
    SalesEngine.startup
    list_of_items = Item.list_of_items
    list_of_items.each do |item|
      assert_kind_of Item, item
    end
  end

  def test_sales_engine_startup_for_merchant
    SalesEngine.startup
    list_of_merchants = Merchant.list_of_merchants
    list_of_merchants.each do |merchant|
      assert_kind_of Merchant, merchant
    end
  end

  def test_sales_engine_startup_for_invoice
    SalesEngine.startup
    list_of_invoices = Invoice.list_of_invoices
    list_of_invoices.each do |invoice|
      assert_kind_of Invoice, invoice
    end
  end
end
