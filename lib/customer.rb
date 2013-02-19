require './lib/get_csv_mod'
require './lib/searching_mod'

class Customer
	extend GetCSV
  extend Searching

  attr_accessor :first_name, :last_name, :id, :created_at, :updated_at, :invoices

  def self.make_customers(testing=false)
    customer_file = "./data/customers.csv"
    if testing
  	  customer_file = "./test/sample/customers.csv"
    end
    
    csv_array = get_csv(customer_file)  
    @list_of_customers = []
    csv_array.each do |cust_hash|
      @list_of_customers.push(Customer.new(cust_hash))
    end
  end

  def self.list_of_customers
    return @list_of_customers
  end

  def self.data
    list_of_customers
  end

  # Find By

  def self.find_by_first_name(match)
    find_by("first_name", match)
  end

  def self.find_by_last_name(match)
    find_by("last_name", match)
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

  def self.find_by_invoices(match)
    find_by("invoices", match)
  end

  # Find All By

  def self.find_all_by_first_name(match)
    find_all_by("first_name", match)
  end

  def self.find_all_by_last_name(match)
    find_all_by("last_name", match)
  end

  def self.find_all_by_id(match)
    find_all_by("id", match)
  end

  def self.find_all_by_created_at(match)
    find_all_by("created_at", match)
  end

  def self.find_all_by_created_at(match)
    find_all_by("created_at", match)
  end

  def self.find_all_by_updated_at(match)
    find_all_by("updated_at", match)
  end

  def self.find_all_by_invoices(match)
    find_all_by("invoices", match)
  end

  # Invoices returns a collection of Invoice instances associated with this object
  def invoices
    Invoice.find_all_by_customer_id(@id)
  end

  def transactions
    customer_invoices = invoices
    if customer_invoices.nil?
      puts "No transactions associated with this customer."
    else
      customer_transactions = []
      customer_invoices.each do |invoice|
        transaction = Transaction.find_by_invoice_id(invoice.id)
        customer_transactions << transaction
      end
      customer_transactions
    end
  end

  def favorite_merchant

    customer_invoices = invoices
    if customer_invoices.nil?
      puts "No merchants associated with this customer."
    else
      merchants = Hash.new(0)
      customer_invoices.each do |invoice|
        transactions = Transaction.find_by_invoice_id(invoice.id)
        if transactions.result == "success"
          value = 1
        elsif transactions.result == "failed"
          value = 0
        end
        merchants[invoice.merchant_id] += value
      end
      favorite_merchant_id = merchants.max_by { |id,quantity| quantity }[0]
      Merchant.find_by_id(favorite_merchant_id)
    end

  end

  # Initialize

  def initialize(input)#takes in a hash
  	@id = input[:id]
  	@first_name = input[:first_name]
  	@last_name = input[:last_name]
  	@created_at = input[:created_at]
  	@updated_at = input[:updated_at]
    @invoices = []
  end
end
