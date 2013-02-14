require './lib/get_csv_mod'
require 'bigdecimal'

class Item
  extend GetCSV

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
