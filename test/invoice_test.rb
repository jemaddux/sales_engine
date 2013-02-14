require 'minitest/autorun'
require "./lib/invoice"

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

  
end















