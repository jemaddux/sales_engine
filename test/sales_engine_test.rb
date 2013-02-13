require 'minitest/autorun'
require "./sales_engine"

class SalesEngineTest < MiniTest::Unit::TestCase
	def test_it_exists
		sales = SalesEngine.new
		assert_kind_of SalesEngine, sales
	end
end