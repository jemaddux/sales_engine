require "./lib/merchant"
require "./lib/customer"
require "./lib/item"
require "./lib/invoice"
require "./lib/transaction"
require "./lib/invoice_item"

class SalesEngine
  #attr_accessor :run_add_relationships

 # def initialize
#    @run_add_relationships = true
  #end


  def self.startup
    Merchant.make_merchants
    Invoice.make_invoices
    Item.make_items
    Customer.make_customers
    Transaction.make_transactions
    InvoiceItem.make_invoice_items
    #if @run_add_relationships == false
      #do nothing
    #else
      Merchant.add_relationships
      @run_add_relationships = false
    #end
  end

=begin
  # optional reload everything
  def self.startup_optional_load(force_reload=false)
    if force_reload || @data_loaded.nil?
      # each model, make_foo
      @data_loaded = true
    end
  end
=end

  # def self.startup_with_pristine_copy
  #   @data = get_csv(...)
  #   @data_pristine = @data.dup
  # end

  # def self.reset
  #   @data = @data_pristine.dup
  # end

end
