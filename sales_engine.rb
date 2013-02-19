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

end
