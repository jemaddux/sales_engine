require 'minitest/autorun'
require "./lib/searching_mod"
require './lib/invoice'

class SearchingTest < MiniTest::Unit::TestCase

  def test_rand_returns_an_object
    Invoice.make_invoices
    random_instance = Invoice.random
    assert_kind_of Invoice, random_instance
  end

  def test_rand_returns_different_objects_each_time
    Invoice.make_invoices
    random_instance_1 = Invoice.random
    random_instance_2 = Invoice.random
    assert_operator random_instance_1, :!= , random_instance_2
  end
  
  def test_find_by_returns_an_instance_of_an_object
    Invoice.make_invoices
    match = Invoice.find_by_id("2")
    assert_kind_of Invoice, match
  end

  def test_find_by_returns_only_one_instance
    Invoice.make_invoices(true)
    array = []
    match = Invoice.find_by_id("3")
    array << match
    assert_operator array.size, :== , 1
  end

  def test_find_by_returns_the_right_instance
    Invoice.make_invoices(true)
    match = Invoice.find_by_status("Sipped")
    assert_equal "Sipped", match.status
  end

  def test_find_all_by_returns_an_array
    Invoice.make_invoices(true)
    match = Invoice.find_all_by_id("3")
    assert_kind_of Array, match
  end

  def test_find_all_by_returns_multiple_instances
    Invoice.make_invoices(true)
    match = Invoice.find_all_by_id("3")
    assert_operator match.size, :== , 2
  end

  def test_find_all_by_returns_an_empty_array_if_no_matches
    Invoice.make_invoices(true)
    match = Invoice.find_all_by_id("40")
    assert_operator match.size, :== , 0
  end

end