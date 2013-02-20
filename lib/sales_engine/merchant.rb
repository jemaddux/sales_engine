require 'sales_engine/get_csv_mod'
require 'sales_engine/item'
require 'sales_engine/relationships_mod'
require 'sales_engine/invoice'
require 'sales_engine/transaction'

module SalesEngine
  class Merchant
    extend GetCSV
    extend Relationships
    extend Searching

    attr_accessor :id, :name, :created_at, :updated_at, :items, :num_items,
                  :how_much_rev, :invoice_ids

    def favorite_customer
      invoices = Invoice.find_all_by_merchant_id(self.id)
      invoice_ids = []
      invoices.each do |invoice|
        invoice_ids << invoice.id
      end
      good_invoice_ids = invoice_ids - bad_transactions(invoice_ids, self.id)
      good_invoices = []
      good_invoice_ids.each do |id|
        good_invoices << Invoice.find_by_id(id)
      end
      good_customer_ids = []
      good_invoices.each do |invoice|
        good_customer_ids << Customer.find_by_id(invoice.customer_id).id
      end
      best_customer_id = good_customer_ids.group_by{|i| i}.max{|x,y| x[1].length <=> y[1].length}[0]

      return best_customer = Customer.find_by_id(best_customer_id)
    end

    # def bad_invoices(invoice_ids, merchant_id)
    #   bad_invoices_array = []
    #   bad_ids = []
    #   bad_ids = bad_transactions(invoice_ids, merchant_id) #=> [] of bad ids

    # end

    def customers_with_pending_invoices
      self.invoice_ids = merchant_invoices(self.id)
      bad_transaction_ids = bad_transactions(self.invoice_ids, self.id)
      bad_transactions = []
      bad_transaction_ids.each do |transaction_id|
        bad_transactions << Transaction.find_by_id(transaction_id)
      end
      bad_customer_ids = []
      bad_customers = []
      bad_transactions.each do |transaction|
        #find bad invoice ids and <<
        bad_customer_ids << Invoice.find_by_id(transaction.invoice_id).customer_id
      end
      bad_customer_ids.each do |id|
        #find bad customers and << into bad_customers
        bad_customers << Customer.find_by_id(id)
      end
      return bad_customers
    end

    def self.revenue(date)
      temp = Merchant.list_of_merchants
      total_rev = 0
      temp.each do |merchant|
        total_rev += merchant.revenue(date)
      end
      return total_rev
      #for each merchant call merchant.revenue(date)
    end

    def self.add_rev(date="all")
      @list_of_merchants.each do |merchant|
        merchant.how_much_rev = merchant.revenue(date)
      end
    end

    def self.most_revenue(x,date="all")
      Merchant.add_rev(date)
      merch_list = Merchant.list_of_merchants
      merch_list.sort! do |a, b|
        a.how_much_rev <=> b.how_much_rev
      end
      merch_list.reverse!
      return merch_list[0..(x-1)]
    end

    def self.most_items(x)
      merch_list = self.data
      merch_list.each do |merchant|
        merchant.num_items = merchant.items.size
      end
      merch_list.sort! do |a, b|
        a.num_items <=> b.num_items
      end
      merch_list.reverse!
      return merch_list[0..(x-1)]
    end

    def revenue(date="all")
      self.invoice_ids = merchant_invoices(self.id)
      self.invoice_ids = self.invoice_ids - bad_transactions(self.invoice_ids, self.id)
      if date != "all"
        self.invoice_ids = remove_dates(self.invoice_ids, self.id, date)
      end
      rev_total = 0.0
      mer_invoice_items = [] ###make empty array of invoiceItems
      self.invoice_ids.each do |id|
        temp_invoice_items = InvoiceItem.find_all_by_invoice_id(id)
        temp_invoice_items.each do |invoice_item|
          mer_invoice_items << invoice_item
        end
      end
      mer_invoice_items.each do |invo_item|
         rev_total += invo_item.quantity.to_i * invo_item.unit_price.to_f
       end
      return BigDecimal("#{rev_total}")
    end

    def remove_dates(invoice_ids, merchant_id, date)
      date = Date.parse(date)
      bad_ids = []
      #Invoices have a :created_at date
      #Find and return an Invoice instance for each invoice_id
      invoice_ids.each do |i_id|
        invoice_date = Date.parse(Invoice.find_by_id(i_id).created_at)
        if date != invoice_date
          bad_ids << i_id
        end
      end
      #If date != Invoice instance.created_at date then
      # bad_ids << invoice_id
      return invoice_ids - bad_ids
    end

    def merchant_invoices(merchant_id)
      invoice_ids_mer = []
      temp_invoices = Invoice.find_all_by_merchant_id(merchant_id)
      temp_invoices.each do |invoi|
        invoice_ids_mer << invoi.id
      end
      return invoice_ids_mer
    end

    def bad_transactions(invoice_ids, merchant_id)
      bad_ids = []
      invoice_ids.each do |id|
        trans = Transaction.find_all_by_invoice_id(id)
        trans = trans.select{|tran| tran.result == "success"}
        if trans.size == 0
          bad_ids << id
        end
      end
      bad_ids
    end



    ##########################################################

    def self.make_merchants(testing = false)
      merchant_file = "./data/merchants.csv"
      if testing
        merchant_file = "./test/sample/merchants.csv"
      end
      data_dump = get_csv(merchant_file)
      @list_of_merchants = []
      data_dump.each do |merchant|
        @list_of_merchants.push(Merchant.new(merchant))
      end
    end

    def self.list_of_merchants
      return @list_of_merchants
    end

    def self.data
      list_of_merchants
    end

    # Find By

    def self.find_by_id(match)
      find_by("id", match)
    end

    def self.find_by_name(match)
      find_by("name", match)
    end

    def self.find_by_created_at(match)
      find_by("created_at", match)
    end

    def self.find_by_updated_at(match)
      find_by("updated_at", match)
    end

    def self.find_by_items(match)
      find_by("items", match)
    end

    def self.find_by_invoices(match)
      find_by("invoices", match)
    end

    # Find All By

    def self.find_all_by_id(match)
      find_all_by("id", match)
    end

    def self.find_all_by_name(match)
      find_all_by("name", match)
    end

    def self.find_all_by_created_at(match)
      find_all_by("created_at", match)
    end

    def self.find_all_by_updated_at(match)
      find_all_by("updated_at", match)
    end

    def self.find_all_by_items(match)
      find_all_by("items", match)
    end

    def self.find_all_by_invoices(match)
      find_all_by("invoices", match)
    end

    # Initialize

    def initialize(merchant={})
      @id = merchant[:id]
      @name = merchant[:name]
      @created_at = merchant[:created_at]
      @updated_at = merchant[:updated_at]
      @items = []
      @num_items = 0
      @how_much_rev = 0
      @invoice_ids = []
      # @invoice_items = []
      # @transactions = [1,2,3,4]
    end

    def self.add_relationships
      self.list_of_merchants.each do |merchant|
        merchant.items = get_items(merchant.id)
      end
    end

    def invoices
      Invoice.find_all_by_merchant_id(@id)
    end

  end
end
