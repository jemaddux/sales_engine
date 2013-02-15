require './lib/get_csv_mod'

class Customer
	extend GetCSV

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
