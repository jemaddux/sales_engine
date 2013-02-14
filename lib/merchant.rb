require './lib/get_csv_mod'
require './lib/item'
require './lib/relationships_mod'
# run the csv import in sales_engine.rb

class Merchant
  extend GetCSV
  extend Relationships

  attr_accessor :id, :name, :created_at, :updated_at, :items, :invoices

  def self.make_merchants(testing = false)
    merchant_file = "./data/merchants.csv"
    if testing
      merchant_file = "./test/sample/merchants.csv"
    end
    data_dump = get_csv(merchant_file)
    @list_of_merchants = []
    data_dump.each do |merchant|
      @list_of_merchants.push(Merchant.new(merchant))
    end
  end

  def self.list_of_merchants
    return @list_of_merchants
  end

  def initialize(merchant)
    @id = merchant[:id]
    @name = merchant[:name]
    @created_at = merchant[:created_at]
    @updated_at = merchant[:updated_at]
    @items = []
    @invoices = []
  end

  def self.add_relationships
    @list_of_merchants.each do |merchant|
      merchant.items = get_items(merchant.id)
    end
  end

end
