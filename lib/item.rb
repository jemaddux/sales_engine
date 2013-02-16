require './lib/get_csv_mod'
require 'bigdecimal'
require './lib/searching_mod'

class Item
  extend GetCSV
  extend Searching

  attr_accessor :name, :id, :created_at, :updated_at, :description, 
    :unit_price, :merchant_id

  def self.make_items(testing=false)
    item_file = "./data/items.csv"
    if testing
      item_file = "./test/sample/items.csv"
    end
    
    csv_array = get_csv(item_file)  
    @list_of_items = []
    csv_array.each do |item_hash|
      @list_of_items.push(Item.new(item_hash))
    end
  end

  def self.list_of_items
    return @list_of_items
  end

  def self.data
    list_of_items
  end

  # Find By

  def self.find_by_name(match)
    find_by("name", match)
  end

  def self.find_by_id(match)
    find_by("id", match)
  end

  def self.find_by_created_at(match)
    find_by("created_at", match)
  end

  def self.find_by_updated_at(match)
    find_by("updated_at", match)
  end

  def self.find_by_description(match)
    find_by("description", match)
  end

  def self.find_by_unit_price(match)
    find_by("unit_price", match)
  end

  def self.find_by_merchant_id(match)
    find_by("merchant_id", match)
  end

  def self.find_by_invoice_items(match)
    find_by("invoice_items", match)
  end

  def self.find_by_merchant(match)
    find_by("merchant", match)
  end

  # Find All By

  def self.find_all_by_name(match)
    find_all_by("name", match)
  end

  def self.find_all_by_id(match)
    find_all_by("id", match)
  end

  def self.find_all_by_created_at(match)
    find_all_by("created_at", match)
  end

  def self.find_all_by_updated_at(match)
    find_all_by("updated_at", match)
  end

  def self.find_all_by_description(match)
    find_all_by("description", match)
  end

  def self.find_all_by_unit_price(match)
    find_all_by("unit_price", match)
  end

  def self.find_all_by_merchant_id(match)
    find_all_by("merchant_id", match)
  end

  def self.find_all_by_invoice_items(match)
    find_all_by("invoice_items", match)
  end

  def self.find_all_by_merchant(match)
    find_all_by("merchant", match)
  end

  def invoice_items
    InvoiceItem.find_all_by_item_id(@id)
  end

  def merchant
    Merchant.find_by_id(@merchant_id)
  end

  # Initialize

  def initialize(input)#takes in a hash
    @id = input[:id]
    @name = input[:name]
    @created_at = input[:created_at]
    @updated_at = input[:updated_at]
    @description = input[:description]
    @merchant_id = input[:merchant_id]
    @unit_price = input[:unit_price]
  end
end
