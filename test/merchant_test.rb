require 'simplecov'
SimpleCov.start

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
    merchant_list = Merchant.make_merchants(true)
    assert_equal Array, merchant_list.class
  end

  #def test_random_merchant_method_returns_a_random_instance

  #def test_find_by_x_match_returns_a_single_instance

  #def test_find_all_by_x_match_returns_all_instances_as_an_array

  #def test_items_method_returns_a_collection_of_items_for_the_merchant

  #def test_invoices_returns_a_collection_of_invoice_instances_for_merchant

  def test_merchant_returns_an_array_when_items_is_called_on_an_instance
    Merchant.make_merchants
    merchant = Merchant.list_of_merchants[42]
    assert_equal Array, merchant.items.class
  end

  def test_merchant_has_right_items_when_called
    Merchant.make_merchants(true)#true for testing
    first_merchant = Merchant.list_of_merchants[0]
    item_hash = {id: "1", name: "Item Qui Esse", description: "Nihil autem sit odio inventore deleniti. Est laudantium ratione distinctio laborum. Minus voluptatem nesciunt assumenda dicta voluptatum porro.", unit_price: "75107", merchant_id: "1", created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC"}
    item = Item.new(item_hash)
    Merchant.add_relationships
    assert_equal Item, first_merchant.items[0].class
  end  

  def test_merchant_can_find_items_by_merchant_id
    Merchant.make_merchants(true)#true for testing
    Item.make_items(true)
    Merchant.add_relationships
    first_merchant = Merchant.list_of_merchants[0]
    item_hash = {id: "1", name: "Item Qui Esse", description: "Nihil autem sit odio inventore deleniti. Est laudantium ratione distinctio laborum. Minus voluptatem nesciunt assumenda dicta voluptatum porro.", unit_price: "75107", merchant_id: "1", created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC"}
    item = Item.new(item_hash)
    assert_equal first_merchant.items[0].name, item.name
  end

  def test_merchant_can_find_items_by_merchant_id_in_real_data
    Merchant.make_merchants
    Item.make_items
    Merchant.add_relationships
    merchant = Merchant.list_of_merchants[3]  
    assert_equal Item, merchant.items[0].class
  end

  def test_merchants_returns_an_array_when_invoices_is_called_on_an_instance
    Merchant.make_merchants
    merchant = Merchant.list_of_merchants[23]
    assert_equal Array, merchant.invoices.class
  end

  def test_merchant_responds_to_find_by_id
    assert Merchant.respond_to?(:find_by_id) 
  end

end







