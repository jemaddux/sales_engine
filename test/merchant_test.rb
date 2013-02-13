require 'minitest/autorun'
require "./lib/merchant"

class MerchantTest < MiniTest::Unit::TestCase
	def test_it_exists
		merchant = Merchant.new
		assert_kind_of Merchant, merchant
	end

	def test_get_csv_loads_data
		merchant_file = "./test/sample/merchants.csv"
		file_contents = Merchant.get_csv(merchant_file)
		assert_operator file_contents.size, :>= , 5
	end
end