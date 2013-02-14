require './lib/get_csv_mod'
require './lib/relationships_mod'

class InvoiceItem
  extend GetCSV
  extend Relationships

  attr_accessor :id, :item_id, :invoice_id, :quantity, :unit_price, 
  :created_at, :updated_at, :item

  def self.make_invoice_items(testing=false)
    invoice_item_file = "./data/invoice_items.csv"
    if testing
      invoice_item_file = "./test/sample/invoice_items.csv"
    end
    
    csv_array = get_csv(invoice_item_file)  
    @list_of_invoice_items = []
    csv_array.each do |invoice_item_hash|
      @list_of_invoice_items.push(InvoiceItem.new(invoice_item_hash))
    end
  end

  def self.list_of_invoice_items
    return @list_of_invoice_items
  end

  def initialize(input)#takes in a hash
    @id = input[:id]
    @item_id = input[:item_id]
    @invoice_id = input[:invoice_id]
    @quantity = input[:quantity]
    @unit_price = input[:unit_price]
    @created_at = input[:created_at]
    @updated_at = input[:updated_at]
    @item = ""
  end

  def self.add_relationships
    list_of_items = Item.list_of_items
    @list_of_invoice_items.each do |invoice_item|
      list_of_items.each do |item|
        invoice_item.item = Item.find_by_id(invoice_item.item_id)
      end
    end
  end
end
