require "sales_engine/merchant"
require "sales_engine/customer"
require "sales_engine/item"
require "sales_engine/invoice"
require "sales_engine/transaction"
require "sales_engine/invoice_item"

module SalesEngine
  #class SalesEngine
    def self.startup
      Merchant.make_merchants
      Invoice.make_invoices
      Item.make_items
      Customer.make_customers
      Transaction.make_transactions
      InvoiceItem.make_invoice_items
      Merchant.add_relationships
    end
  #end
end
