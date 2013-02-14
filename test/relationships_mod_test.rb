require 'minitest/autorun'
require './lib/relationships_mod'
require './lib/merchant'
require './lib/item'

class RelationshipModuleTest < MiniTest::Unit::TestCase
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
    Merchant.add_relationships
    first_merchant = Merchant.list_of_merchants[0]
    assert_equal first_merchant.items, "1234"
  end

end
