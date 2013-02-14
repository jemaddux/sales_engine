require './lib/get_csv_mod'
require './lib/searching_mod'

class Invoice
	extend GetCSV
  extend Searching

  attr_accessor :id, :customer_id, :merchant_id, :status, :created_at, :updated_at

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
    find_by("id", match)
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
    @id = input[:id]
    @customer_id = input[:customer_id]
    @merchant_id = input[:merchant_id]
    @status = input[:status]
    @created_at = input[:created_at]
    @updated_at = input[:updated_at]
  end
end
