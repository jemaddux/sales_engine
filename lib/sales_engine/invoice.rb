require 'sales_engine/get_csv_mod'
require 'sales_engine/searching_mod'
require 'sales_engine/transaction'
require "sales_engine/invoice_item"
require 'sales_engine/customer'

module SalesEngine
  class Invoice
    extend GetCSV
    extend Searching

    attr_accessor :id,
                  :customer_id,
                  :merchant_id,
                  :status,
                  :created_at,
                  :updated_at

    def self.make_invoices(testing=false)
      invoice_file = "./data/invoices.csv"
      if testing
        invoice_file = "./test/sample/invoices.csv"
      end

      csv_array = get_csv(invoice_file)
      @list_of_invoices = []
      csv_array.each do |invoice_hash|
        @list_of_invoices.push(Invoice.new(invoice_hash))
      end
    end

    def self.list_of_invoices
      return @list_of_invoices
    end

    def self.data
      list_of_invoices
    end

    # Find By

    def self.find_by_id(match)
      find_by("id", match.to_i)
    end

    def self.find_by_customer_id(match)
      find_by("customer_id", match)
    end

    def self.find_by_merchant_id(match)
      find_by("merchant_id", match)
    end

    def self.find_by_status(match)
      find_by("status", match)
    end

    def self.find_by_created_at(match)
      find_by("created_at", match)
    end

    def self.find_by_updated_at(match)
      find_by("updated_at", match)
    end

    # Find All By

    def self.find_all_by_id(match)
      find_all_by("id", match)
    end

    def self.find_all_by_customer_id(match)
      find_all_by("customer_id", match)
    end

    def self.find_all_by_merchant_id(match)
      find_all_by("merchant_id", match)
    end

    def self.find_all_by_status(match)
      find_all_by("status", match)
    end

    def self.find_all_by_created_at(match)
      find_all_by("created_at", match)
    end

    def self.find_all_by_updated_at(match)
      find_all_by("updated_at", match)
    end

    # Initialize

    def initialize(input)#takes in a hash
      @id = input[:id].to_i
      @customer_id = input[:customer_id].to_i
      @merchant_id = input[:merchant_id].to_i
      @status = input[:status]
      @created_at = input[:created_at]
      @updated_at = input[:updated_at]
    end

    def transactions
      Transaction.find_all_by_invoice_id(@id)
    end

    def invoice_items
      InvoiceItem.find_all_by_invoice_id(@id)
    end

    def items
      invoice_items = InvoiceItem.find_all_by_invoice_id(@id)
      some_array = []
      invoice_items.each do |x|
        some_array << Item.find_by_id(x.item_id)
      end
      some_array
    end

    def invoice_items
      InvoiceItem.find_all_by_invoice_id(@id)
    end

    def customer
      Customer.find_by_id(@customer_id)
    end

    def self.current_time
      time = Time.now.utc
      time.to_s
    end

    def self.find_all_paid_invoices
      @list_of_invoices.select do |invoice|
        invoice.transactions.any? {|transactions| transactions.result == "success"}
      end
    end

    def self.new_invoice_id
      last_invoice = @list_of_invoices[-1]
      last_invoice_id = last_invoice.id
      new_invoice_id = last_invoice_id.to_i + 1
      new_invoice_id.to_s
    end

    def self.add_invoice(input)
      invoice_data = {
        :id => new_invoice_id,
        :customer_id => input[:customer].id.to_i,
        :merchant_id => input[:merchant].id,
        :status => input[:status],
        :created_at => current_time,
        :updated_at => current_time
      }
      Invoice.new(invoice_data)
    end

    def self.create(input)
      new_invoice = add_invoice(input)
      @list_of_invoices << new_invoice
      item_collection = InvoiceItem.collect_invoice_items(input[:items])
      invoice_id = @list_of_invoices[-1].id
      InvoiceItem.add_invoice_items(item_collection, invoice_id)
      new_invoice
    end

    def charge(input)
      input[:invoice_id] = @id
      Transaction.add_transaction(input)
    end
  end
end
