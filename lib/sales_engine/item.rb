require 'sales_engine/get_csv_mod'
require 'bigdecimal'
require 'sales_engine/searching_mod'

module SalesEngine
  class Item
    extend GetCSV
    extend Searching

    attr_accessor :name,
                  :id,
                  :created_at,
                  :updated_at,
                  :description,
                  :unit_price,
                  :merchant_id

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
      convert_prices
    end

    def self.list_of_items
      return @list_of_items
    end

    def self.convert_prices
      @list_of_items.each do |item|
        if item.unit_price
          price = (item.unit_price.to_f)/100
          item.unit_price = BigDecimal(price.to_s)
        end
      end
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

    # Add to invoiceitems.rb?
    def self.get_item_revenues
      item_revenues = Hash.new(0)
      InvoiceItem.data.each do |invoice_item|
        quantity = BigDecimal(invoice_item.quantity.to_i)
        unit_price_cents = BigDecimal(invoice_item.unit_price.to_i)
        unit_price_dollars = (unit_price_cents / BigDecimal('100'))
        revenue = (quantity * unit_price_dollars)
        item_revenues[invoice_item.item_id] += revenue
        # To-do: Format in dollars & cents to 2 decimal places
      end
      item_revenues
    end

    def self.most_revenue(count)
      item_revenues = get_item_revenues
      top_item_revenues = item_revenues.sort_by{ |k,v| -v }[0..(count-1)]
      top_item_instances = []
      top_item_revenues.each do |item_id, revenue|
        top_item_instances << Item.find_by_id(item_id)
      end
      top_item_instances
    end

    # Add to invoiceitems.rb?
    def self.get_item_quantities
      item_quantities = Hash.new(0)
      InvoiceItem.data.each do |invoice_item|
        item_quantities[invoice_item.item_id] += invoice_item.quantity.to_i
      end
      item_quantities
    end

    def self.most_items(count)
      item_quantities = get_item_quantities
      top_item_quantities = item_quantities.sort_by{ |k,v| -v }[0..(count-1)]
      top_item_instances = []
      top_item_quantities.each do |item_id, quantity|
        top_item_instances << Item.find_by_id(item_id)
      end
    end

    def invoice_items
      InvoiceItem.find_all_by_item_id(@id)
    end

    def merchant
      Merchant.find_by_id(@merchant_id)
    end

    def invoice(invoice_id)
      Invoice.find_by_id(invoice_id)
    end

    def best_day
      invoice_item_instances = InvoiceItem.find_all_by_item_id(@id)

      item_sales = Hash.new(0)
      invoice_item_instances.each do |invoice_item|
        invoice_id = invoice_item.invoice_id
        invoice = Invoice.find_by_id(invoice_id)
        invoice_date = Date.parse(invoice.created_at)
        item_sales[invoice_date] += invoice_item.quantity.to_i
      end
      item_sales.max_by { |date,value| value }[0]
    end

    # Initialize

    def initialize(input)#takes in a hash
      @id = input[:id].to_i
      @name = input[:name]
      @created_at = input[:created_at]
      @updated_at = input[:updated_at]
      @description = input[:description]
      @merchant_id = input[:merchant_id].to_i
      @unit_price = input[:unit_price]
    end
  end
end
