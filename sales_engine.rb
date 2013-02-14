require "./lib/merchant"
require "./lib/customer"
require "./lib/item"
require "./lib/invoice"

class SalesEngine

  def self.startup
    Merchant.make_merchants
    Merchant.add_relationships
    Invoice.make_invoices
    Item.make_items
    Customer.make_customers
  end

end
