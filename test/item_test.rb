#require 'simplecov'
#SimpleCov.start
#require 'minitest/autorun'
require "sales_engine/item"
require 'bigdecimal'
require_relative 'support'

module SalesEngine
  class ItemTest < MiniTest::Unit::TestCase
  	def test_it_exists
  		item = Item.new({})
  		assert_kind_of Item, item
  	end

  	def test_get_csv_loads_data
  		item_file = "./test/sample/items.csv"
  		file_contents = Item.get_csv(item_file)
  		assert_operator file_contents.size, :>= , 5
  	end

    def test_item_has_id
      items = Item.new({id: 4})
      assert_equal 4, items.id
    end

    def test_items_has_name
      item = Item.new({name: "Jimmy"})
      assert_equal "Jimmy", item.name
    end

    def test_items_has_created_at_time
      time_obj = Time.now
      item = Item.new({created_at: time_obj})
      assert_equal time_obj, item.created_at
    end

    def test_item_has_upadated_at_time
      time_obj = Time.now
      item = Item.new({updated_at: time_obj})
      assert_equal time_obj, item.updated_at
    end

    def test_can_create_an_array_of_items_from_sample_items_csv
      Item.make_items(true)#true for testing
      @list_of_items = Item.list_of_items 
      assert_equal Array, @list_of_items.class
    end

    def test_can_create_a_item_instance_from_sample_items_csv
      Item.make_items(true)#true for testing, false by default
      @list_of_items = Item.list_of_items
      assert_kind_of Item, @list_of_items[0]
    end

    def test_can_create_an_item_with_the_right_name
      Item.make_items(true)#true for testing, false by default
      @list_of_items = Item.list_of_items
      assert_equal "Item Qui Esse", @list_of_items[0].name
    end

    def test_item_has_description
      item = Item.new({description: "Jimmy"})
      assert_equal "Jimmy", item.description
    end

    def test_item_has_unit_price
      unit_price_var = 40.25
      item = Item.new({unit_price: unit_price_var})
      assert_equal unit_price_var, item.unit_price
    end

    def test_item_has_merchant_id
      item = Item.new({merchant_id: 1})
      assert_equal 1, item.merchant_id
    end

    def test_that_calling_invoice_items_on_an_item_instance_returns_an_array
      Item.make_items
      item = Item.list_of_items[23]
      assert_equal Array, item.invoice_items.class
    end

    # :name, :id, :created_at, :updated_at, :description, :unit_price, :merchant_id, :invoice_items, :merchant

    def test_item_responds_to_find_by_name
      assert Item.respond_to?(:find_by_name) 
    end

      def test_item_responds_to_find_by_id
      assert Item.respond_to?(:find_by_id) 
    end

    def test_item_responds_to_find_by_created_at
      assert Item.respond_to?(:find_by_created_at) 
    end

    def test_item_responds_to_find_by_updated_at
      assert Item.respond_to?(:find_by_updated_at) 
    end

    def test_item_responds_to_find_by_description
      assert Item.respond_to?(:find_by_description) 
    end

    def test_item_responds_to_find_by_unit_price
      assert Item.respond_to?(:find_by_unit_price) 
    end

    def test_item_responds_to_find_by_merchant_id
      assert Item.respond_to?(:find_by_merchant_id) 
    end

    def test_item_responds_to_find_by_invoice_items
      assert Item.respond_to?(:find_by_invoice_items) 
    end

    def test_item_responds_to_find_by_merchant
      assert Item.respond_to?(:find_by_merchant) 
    end


  ################################################

    def test_item_find_by_name_returns_the_correct_name
      Item.make_items(true)#true for testing, false by default
      item = Item.find_by_name("Item Quo Magnam")
      assert_equal "Item Quo Magnam", item.name
    end  

    def test_item_find_by_id_returns_the_correct_id
      Item.make_items(true)#true for testing, false by default
      item = Item.find_by_id("3")
      assert_equal "3", item.id
    end  

    def test_item_find_by_created_at_returns_the_correct_created_at
      Item.make_items(true)#true for testing, false by default
      item = Item.find_by_created_at("2012-03-27 14:53:59 UTC")
      assert_equal "2012-03-27 14:53:59 UTC", item.created_at
    end

    def test_item_find_by_updated_at_returns_the_correct_time
      Item.make_items(true)#true for testing, false by default
      item = Item.find_by_updated_at("2012-03-27 14:53:59 UTC")
      assert_equal "2012-03-27 14:53:59 UTC", item.updated_at
    end  

  ############################################

    def test_item_find_all_by_name_returns_the_amount
      Item.make_items(true)#true for testing, false by default
      items = Item.find_all_by_name("Item Quo Magnam")
      assert_equal 5, items.count
    end

    def test_item_find_all_by_id_returns_the_count
      Item.make_items(true)#true for testing, false by default
      items = Item.find_all_by_id("3")
      assert_equal 1, items.count
    end  

    def test_item_find_all_by_created_at_returns_the_correct_amount
      Item.make_items(true)#true for testing, false by default
      items = Item.find_all_by_created_at("2012-03-27 14:53:59 UTC")
      assert_equal 13, items.count
    end

    def test_item_find_all_by_updated_at_returns_the_correct_time
      Item.make_items(true)#true for testing, false by default
      items = Item.find_all_by_updated_at("2012-03-27 14:53:59 UTC")
      assert_equal 13, items.count
    end

    def test_invoice_items_instance_method_returns_an_array
      item = Item.new({:id => "1"})
      InvoiceItem.make_invoice_items(true)#true for testing, false by default
      assert_equal Array, item.invoice_items.class 
    end

    def test_invoice_items_instance_method_returns_correct_values
      item = Item.new({:id => "539"})
      InvoiceItem.make_invoice_items(true)#true for testing, false by default
      invoice_items = item.invoice_items
      assert_equal "539", invoice_items[0].item_id
    end

    def test_merchant_instance_method_returns_an_instance
      item = Item.new({:merchant_id => "1"})
      merchants = Merchant.make_merchants(true)
      assert_kind_of Merchant, item.merchant
    end

    def test_merchant_instance_method_returns_correct_instance
      item = Item.new({:merchant_id => "2"})
      merchants = Merchant.make_merchants(true)
      merchant = item.merchant
      assert_equal "2", merchant.id
    end

    def test_get_item_revenues_returns_a_hash
      Item.make_items
      InvoiceItem.make_invoice_items
      Transaction.make_transactions
      assert_kind_of Hash, Item.get_item_revenues
    end

    def test_values_in_get_item_revenues_hash_are_bigdecimals
      Item.make_items
      InvoiceItem.make_invoice_items
      Transaction.make_transactions
      item_revenues = Item.get_item_revenues
      assert_kind_of BigDecimal, item_revenues.values[0]
    end

    def test_most_revenue_returns_array_of_item_instances
      Item.make_items
      InvoiceItem.make_invoice_items
      Transaction.make_transactions
      most_revenue = Item.most_revenue(5)
      assert_kind_of Array, most_revenue
      assert_equal 5, most_revenue.count
    end

    def test_get_item_quantities_returns_a_hash
      Item.make_items
      InvoiceItem.make_invoice_items
      Transaction.make_transactions
      assert_kind_of Hash, Item.get_item_quantities
    end

    def test_values_in_get_item_quantities_hash_are_fixnum
      Item.make_items
      InvoiceItem.make_invoice_items
      Transaction.make_transactions
      item_quantities = Item.get_item_quantities
      assert_kind_of Fixnum, item_quantities.values[0]
    end

    def test_most_items_returns_array_of_item_instances
      Item.make_items
      InvoiceItem.make_invoice_items
      Transaction.make_transactions
      most_items = Item.most_items(5)
      assert_kind_of Array, most_items
      assert_equal 5, most_items.count
    end

    def test_best_day_returns_a_date
      Item.make_items
      InvoiceItem.make_invoice_items
      Invoice.make_invoices
      Transaction.make_transactions
      item = Item.find_by_id("965")
      assert_kind_of Date, item.best_day
    end

    def test_best_day_returns_right_date
      Item.make_items
      InvoiceItem.make_invoice_items
      Invoice.make_invoices
      Transaction.make_transactions
      item = Item.find_by_id("965")
      date = Date.parse("Sat, 24 Mar 2012")
      assert_equal date, item.best_day
    end
  end
end
