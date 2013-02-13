require 'minitest/autorun'
require "./lib/item"

class ItemTest < MiniTest::Unit::TestCase
	def test_it_exists
		item = Item.new
		assert_kind_of Item, item
	end

	def test_get_csv_loads_data
		item_file = "./test/sample/items.csv"
		file_contents = Item.get_csv(item_file)
		assert_operator file_contents.size, :>= , 5
	end
end