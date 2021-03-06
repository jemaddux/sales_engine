require 'sales_engine/get_csv_mod'
require 'sales_engine/relationships_mod'
require 'sales_engine/searching_mod'

module SalesEngine
  class InvoiceItem
    extend GetCSV
    extend Searching
    extend Relationships

    attr_accessor :id,
                  :item_id,
                  :invoice_id,
                  :quantity,
                  :unit_price,
                  :created_at,
                  :updated_at,
                  :item,
                  :invoice

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

    def self.data
      list_of_invoice_items
    end

    # Find By

    def self.find_by_id(match)
      find_by("id", match)
    end

    def self.find_by_item_id(match)
      find_by("item_id", match)
    end

    def self.find_by_invoice_id(match)
      find_by("invoice_id", match)
    end

    def self.find_by_quantity(match)
      find_by("quantity", match)
    end

    def self.find_by_unit_price(match)
      find_by("unit_price", match.to_s)
    end

    def self.find_by_created_at(match)
      find_by("created_at", match)
    end

    def self.find_by_updated_at(match)
      find_by("updated_at", match)
    end

    def self.find_by_item(match)
      find_by("item", match)
    end

    def self.find_by_invoice(match)
      find_by("invoice", match)
    end

    # Find All By

    def self.find_all_by_id(match)
      find_all_by("id", match)
    end

    def self.find_all_by_item_id(match)
      find_all_by("item_id", match)
    end

    def self.find_all_by_invoice_id(match)
      find_all_by("invoice_id", match)
    end

    def self.find_all_by_quantity(match)
      find_all_by("quantity", match.to_s)
    end

    def self.find_all_by_unit_price(match)
      find_all_by("unit_price", match)
    end

    def self.find_all_by_created_at(match)
      find_all_by("created_at", match)
    end

    def self.find_all_by_updated_at(match)
      find_all_by("updated_at", match)
    end

    def self.find_all_by_item(match)
      find_all_by("item", match)
    end

    def self.find_all_by_invoice(match)
      find_all_by("invoice", match)
    end

    # Invoice returns an instance of Invoice assocatied with this object
    def invoice
      Invoice.find_by_id(@invoice_id)
    end

    # Item returns an instance of item assocaited with this object
    def item
      Item.find_by_id(@item_id)
    end

    # Initialize

    def initialize(input)#takes in a hash
      @id = input[:id].to_i
      @item_id = input[:item_id].to_i
      @invoice_id = input[:invoice_id].to_i
      @quantity = input[:quantity]
      @unit_price = input[:unit_price]
      @created_at = input[:created_at]
      @updated_at = input[:updated_at]
      @item = Item.new({})
      @invoice = Invoice.new({})
    end

    def self.add_relationships
      # list_of_items = Item.list_of_items
      # @list_of_invoice_items.each do |invoice_item|
      #   list_of_items.each do |item|
      #     invoice_item.item = Item.find_by_id(invoice_item.item_id)
      #   end
      # end
    end

    def self.new_invoice_item_id
      last_invoice_item = @list_of_invoice_items[-1]
      last_invoice_item_id = last_invoice_item.id
      new_invoice_item_id = last_invoice_item_id.to_i + 1
      new_invoice_item_id.to_s
    end

    def self.current_time
      time = Time.now.utc
      time.to_s
    end

    def self.collect_invoice_items(item_array)
      item_hash = Hash.new(0)
      item_array.each do |item|
        item_hash[item] += 1
      end
      item_hash.to_a
    end

    def self.add_invoice_items(item_collection, invoice_id)
      invoice_items = []
      item_collection.each do |array_of_item_and_quantity|
        invoice_item = {
          :id => new_invoice_item_id.to_i,
          :item_id => array_of_item_and_quantity[0].id.to_i,
          :invoice_id => invoice_id.to_i,
          :quantity => array_of_item_and_quantity[1].to_s,
          :unit_price => array_of_item_and_quantity[0].unit_price,
          :created_at => current_time,
          :updated_at => current_time
        }
        new_invoice_item = InvoiceItem.new(invoice_item)
        invoice_items << new_invoice_item
        @list_of_invoice_items << new_invoice_item
      end
      invoice_items
    end
  end
end
