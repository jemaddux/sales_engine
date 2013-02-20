#require 'simplecov'
#SimpleCov.start
#require 'minitest/autorun'
require "sales_engine/invoice_item"
#require 'minitest/pride'
require_relative 'support'

module SalesEngine
  class InvoiceItemTest < MiniTest::Unit::TestCase
    def test_it_exists
      invoice_item = InvoiceItem.new({})
      assert_kind_of InvoiceItem, invoice_item
    end

    def test_get_csv_loads_data
      invoice_item_file = "./test/sample/invoice_items.csv"
      file_contents = InvoiceItem.get_csv(invoice_item_file)
      assert_operator file_contents.size, :>= , 5
    end

    def test_that_we_can_get_an_id_from_an_instance
      invoice_item = InvoiceItem.new(:id => "1")
      assert_equal "1", invoice_item.id
    end

    def test_that_we_can_get_an_item_id_from_an_instance
      invoice_item = InvoiceItem.new(:item_id => "3")
      assert_equal "3", invoice_item.item_id
    end

    def test_that_we_can_get_an_invoice_id_from_an_instance
      invoice_item = InvoiceItem.new(:invoice_id => "25")
      assert_equal "25", invoice_item.invoice_id
    end

    def test_that_we_can_get_a_quantity_from_an_instance
      invoice_item = InvoiceItem.new(:quantity => "5")
      assert_equal "5", invoice_item.quantity
    end

    def test_that_we_can_get_a_unit_price_from_an_instance
      unit_price_var = 40.25
      invoice_item = InvoiceItem.new(:unit_price => unit_price_var)
      assert_equal unit_price_var, invoice_item.unit_price
    end

    def test_that_we_can_get_an_invoice_created_date_from_an_instance
      time = Time.now
      invoice_item = InvoiceItem.new(:updated_at => time)
      assert_equal time, invoice_item.updated_at
    end

    def test_that_we_can_get_an_invoice_updated_date_from_an_instance
      time = Time.now
      invoice_item = InvoiceItem.new(:updated_at => time)
      assert_equal time, invoice_item.updated_at
    end

    def test_that_we_can_create_invoice_objects_using_simulated_data
      single_invoice_item = {
        :id => "1",
        :item_id => "3",
        :invoice_id => "25",
        :quantity => "5",
        :unit_price => "13635",
        :created_at => "2012-03-25 09:54:09 UTC",
        :updated_at => "2012-03-27 14:53:59 UTC"
      }
      assert_kind_of InvoiceItem, InvoiceItem.new(single_invoice_item)
    end

    def test_that_calling_new_invoices_returns_an_array
      invoice_item_list = InvoiceItem.make_invoice_items(true)
      assert_equal Array, invoice_item_list.class
    end

    def test_that_calling_invoice_on_an_invoiceItem_instance_returns_an_instance_of_invoice
      InvoiceItem.make_invoice_items
      invoice_item = InvoiceItem.list_of_invoice_items[23]
      assert_equal Invoice, invoice_item.invoice.class
    end

    def test_invoice_items_responds_to_find_by_id
      assert InvoiceItem.respond_to?(:find_by_id) 
    end

    def test_invoice_items_responds_to_find_by_item_id
      assert InvoiceItem.respond_to?(:find_by_item_id) 
    end

    def test_invoice_items_responds_to_find_by_invoice_id
      assert InvoiceItem.respond_to?(:find_by_invoice_id) 
    end

    def test_invoice_items_responds_to_find_by_quantity
      assert InvoiceItem.respond_to?(:find_by_quantity) 
    end

    def test_invoice_items_responds_to_find_by_unit_price
      assert InvoiceItem.respond_to?(:find_by_unit_price) 
    end

    def test_invoice_items_responds_to_find_by_created_at
      assert InvoiceItem.respond_to?(:find_by_created_at) 
    end

    def test_invoice_items_responds_to_find_by_updated_at
      assert InvoiceItem.respond_to?(:find_by_updated_at) 
    end

    def test_invoice_items_responds_to_find_by_item
      assert InvoiceItem.respond_to?(:find_by_item) 
    end

    def test_invoice_items_responds_to_find_by_invoice
      assert InvoiceItem.respond_to?(:find_by_invoice) 
    end

  ################################################

    def test_invoice_items_find_by_id_returns_the_correct_id
      InvoiceItem.make_invoice_items(true)#true for testing, false by default
      invoice_items = InvoiceItem.find_by_id("3")
      assert_equal "3", invoice_items.id
    end  

    def test_invoice_items_find_by_updated_at_returns_the_correct_time
      InvoiceItem.make_invoice_items(true)#true for testing, false by default
      invoice_item = InvoiceItem.find_by_updated_at("2012-03-27 14:54:09 UTC")
      assert_equal "2012-03-27 14:54:09 UTC", invoice_item.updated_at
    end  

  ############################################

    def test_invoice_item_find_all_by_id_returns_the_count
      InvoiceItem.make_invoice_items(true)#true for testing, false by default
      invoice_items = InvoiceItem.find_all_by_id("3")
      assert_equal 1, invoice_items.count
    end  

    def test_invoice_item_find_all_by_created_at_returns_the_correct_amount
      InvoiceItem.make_invoice_items(true)#true for testing, false by default
      invoice_items = InvoiceItem.find_all_by_created_at("2012-03-27 14:54:09 UTC")
      assert_equal 15, invoice_items.count
    end

  ################################################

    def test_that_invoice_item_find_by_item_id_returns_the_correct_item
      InvoiceItem.make_invoice_items(true)#true for testing, false by default
      invoice_item = InvoiceItem.find_by_item_id("1832")
      assert_equal "1832", invoice_item.item_id
    end

    def test_that_invoice_item_find_by_invoice_id_returns_the_correct_item
      InvoiceItem.make_invoice_items(true)#true for testing, false by default
      invoice_item = InvoiceItem.find_by_invoice_id("2")
      assert_equal "2", invoice_item.invoice_id
    end

    def test_that_invoice_item_find_by_quantity_returns_the_correct_item
      InvoiceItem.make_invoice_items(true)#true for testing, false by default
      invoice_item = InvoiceItem.find_by_quantity("6")
      assert_equal "8", invoice_item.id
    end

    def test_that_invoice_item_find_by_unit_price_returns_the_correct_item
      InvoiceItem.make_invoice_items(true)#true for testing, false by default
      invoice_item = InvoiceItem.find_by_unit_price("13635")
      assert_equal "1", invoice_item.invoice_id
    end

    def test_that_invoice_item_find_by_created_at_returns_the_correct_item
      InvoiceItem.make_invoice_items(true)#true for testing, false by default
      invoice_item = InvoiceItem.find_by_created_at("2012-03-27 14:54:09 UTC")
      assert_equal "1", invoice_item.invoice_id
    end

    def test_that_item_instance_method_returns_an_instance
      invoice_item = InvoiceItem.new(:item_id => "7")
      Item.make_items(true)
      assert_kind_of Item, invoice_item.item
    end

    def test_that_item_instance_method_returns_correct_instance
      invoice_item = InvoiceItem.new(:item_id => "7")
      Item.make_items(true)
      item = invoice_item.item
      assert_equal "7", item.id
    end

    def test_that_invoice_instance_method_returns_an_instance
      invoice_item = InvoiceItem.new(:invoice_id => "6")
      Invoice.make_invoices(true)
      assert_kind_of Invoice, invoice_item.invoice
    end

    def test_that_invoice_instance_method_returns_correct_values
      invoice_item = InvoiceItem.new(:invoice_id => "6")
      Invoice.make_invoices(true)
      invoice = invoice_item.invoice
      assert_equal "6", invoice.id
    end
  end
end
