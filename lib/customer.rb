require './lib/get_csv_mod'

class Customer
	extend GetCSV


  attr_accessor :name, :id

  def self.make_customers
  	#runs through each customers from the get_csv and sends the to initialize
  	#adds each customer to a @list_of_customers which is an array
  	#this will run from sales_engine.rb
  end

  def initialize()#takes in a hash
  	@id = input[:id]
  	#returns a customer instance
  end
end