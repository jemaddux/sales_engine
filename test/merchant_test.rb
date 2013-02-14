#get simplecov

require 'minitest/autorun'
require "./lib/merchant"

class MerchantTest < MiniTest::Unit::TestCase
	def test_it_exists
		merchant = Merchant.new({})
		assert_kind_of Merchant, merchant
	end

	def test_get_csv_loads_data
		merchant_file = "./test/sample/merchants.csv"
		file_contents = Merchant.get_csv(merchant_file)
		assert_operator file_contents.size, :>= , 5
	end

  #def test_convert_time_strings_to_date_objects

  def test_that_we_can_get_a_merchant_id_from_an_instance
    merchant = Merchant.new(:id => "1")
    assert_equal "1", merchant.id
  end

  def test_that_we_can_get_a_merchant_name_from_an_instance
    merchant = Merchant.new(:name => "Mike")
    assert_equal "Mike", merchant.name
  end

  def test_that_we_can_get_a_merchant_created_date_from_an_instance
    time = Time.now
    merchant = Merchant.new(:created_at => time)
    assert_equal time, merchant.created_at
  end

  def test_that_we_can_get_a_merchant_updated_date_from_an_instance
    time = Time.now
    merchant = Merchant.new(:updated_at => time)
    assert_equal time, merchant.updated_at
  end

  def test_that_we_can_create_merchant_objects_using_simulated_data
    single_merchant = {
      :id => "1",
      :name => "Mike, Smith",
      :created_at => "2012-03-27 14:53:59 UTC",
      :updated_at => "2012-03-27 14:53:59 UTC"
    }
    assert_kind_of Merchant, Merchant.new(single_merchant)
  end

  def test_that_calling_new_merchants_returns_an_array
    merchant_list = Merchant.new_merchants("./test/sample/merchants.csv")
    assert_equal Array, merchant_list.class
  end

  def test_that_the_first_array_returns

  end

  #def test_random_merchant_method_returns_a_random_instance

  #def test_find_by_x_match_returns_a_single_instance

  #def test_find_all_by_x_match_returns_all_instances_as_an_array

  #def test_items_method_returns_a_collection_of_items_for_the_merchant

  #def test_invoices_returns_a_collection_of_invoice_instances_for_merchant

end