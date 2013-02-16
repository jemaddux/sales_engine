require "./lib/merchant"
require "./lib/customer"
require "./lib/item"
require "./lib/invoice"
require "./lib/transaction"
require "./lib/invoice_item"

class SalesEngine

  def self.startup
    Merchant.make_merchants
    Merchant.add_relationships
    Invoice.make_invoices
    Item.make_items
    Customer.make_customers
    Transaction.make_transactions
    InvoiceItem.make_invoice_items
  end

end
