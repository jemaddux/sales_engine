require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require './lib/relationships_mod'
require './lib/merchant'
require './lib/item'
require 'minitest/pride'

class RelationshipModuleTest < MiniTest::Unit::TestCase
  

  # def test_invoiceitem_can_find_items_by_item_id
  #   InvoiceItem.make_invoice_items
  #   InvoiceItem.add_relationships
  #   invoice_item = InvoiceItem.list_of_invoice_items[42]
  #   assert_equal Item, invoice_item.item.class
  # end
end













