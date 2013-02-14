require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require "./lib/searching_mod"
require './lib/invoice'

class SearchDouble
  extend Searching

  def self.data
    [
      "One",
      "Two",
      "Three"
    ]
  end

  def self.find_by_length(input)
    find_by("length", input)
  end

  def self.find_all_by_length(input)
    find_all_by("length", input)
  end

  def self.find_by_upcase(input)
    find_by("upcase", input)
  end

end

class SearchingTest < MiniTest::Unit::TestCase

  def test_random_returns_an_object
    assert SearchDouble.random
  end
  
  def test_find_by_returns_an_instance_of_an_object
    assert_equal "Three", SearchDouble.find_by_length(5)
  end

  def test_find_by_returns_only_one_instance
    result = SearchDouble.find_by_length(3)
    refute result.respond_to?(:each)    
  end

  def test_find_all_by_returns_an_array
    result = SearchDouble.find_all_by_length(3)
    assert_equal 2, result.count
  end

  def test_find_all_by_returns_an_empty_array_if_no_matches
    result = SearchDouble.find_all_by_length(1)
    assert_equal 0, result.count
  end

  def test_find_by_is_case_insensitive
    result = SearchDouble.find_by_upcase("One")
    assert_equal "One", result
  end

end
