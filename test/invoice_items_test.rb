require 'minitest/autorun'
require "./lib/invoice_item"

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
end