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

  def initialize(input)#takes in a hash
  	@id = input[:id]
  	@first_name = input[:first_name]
  	@last_name = input[:last_name]
  	@created_at = input[:created_at]
  	@updated_at = input[:updated_at]
    @invoices = []
  end
end
