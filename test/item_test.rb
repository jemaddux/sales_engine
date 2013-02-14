require 'minitest/autorun'
require "./lib/item"
require 'bigdecimal'

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

  def test_that_calling_merchant_on_an_item_instance_returns_an_instance_of_merchant
    Item.make_items
    item = Item.list_of_items[2]
    assert_equal Merchant, item.merchant.class
  end
end













