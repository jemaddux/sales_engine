require './lib/get_csv_mod'
require './lib/item'
require './lib/relationships_mod'
require './lib/invoice'
require './lib/transaction'

class Merchant
  extend GetCSV
  extend Relationships
  extend Searching

  attr_accessor :id, :name, :created_at, :updated_at, :items, :num_items, :how_much_rev, :invoices2

  def get_rev(merch_id)
    merch_id
  end

  # def self.most_revenue(x)
  #   merch_list = self.data
  #   merch_list.each do |merchant|
  #     merchant.how_much_rev = merchant.revenue
  #   end
  #   merch_list.sort! do |a, b|
  #     a.how_much_rev <=> b.how_much_rev
  #   end
  #   merch_list.reverse!
  #   return merch_list[0..(x-1)]
  # end

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

  def revenue
    merchant_revenue = BigDecimal('0.00')
    invoice_items = []
    invoice_ids = []
    temp = self.successful_invoices
    if temp == []
      return merchant_revenue
    end
    temp.each do |invoice|
      invoice_ids << invoice.id
    end
    invoice_items = InvoiceItem.data
    invoice_items.reject! {|i| !invoice_ids.include?(i.invoice_id)}
    invoice_items.each do |invoice_item|
      merchant_revenue += BigDecimal("#{invoice_item.unit_price.to_i*invoice_item.quantity.to_i}.00")
    end
    return merchant_revenue
  end

  def successful_invoices
    ids = []
    self.successful_transactions.each do |transaction|
      ids << transaction.invoice_id
    end
    successes =  Invoice.data
    successes.reject! {|i| !ids.include?(i.id)}
    return successes
  end

  def successful_transactions
    successes = []
    if ((@id == nil) || (@id.to_i > 100))
      return []
    end
    invoices = Invoice.find_all_by_merchant_id(self.id)
    if invoices == []  
      return successes
    end
    ids = []
    invoices.each do |invoice|
      ids << invoice.id
    end
    successes =  Transaction.data
    successes.reject! {|i| !ids.include?(i.invoice_id)}
    successes.select! {|i| i.result == "success"}
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

  def initialize(merchant)
    @id = merchant[:id]
    @name = merchant[:name]
    @created_at = merchant[:created_at]
    @updated_at = merchant[:updated_at]
    @items = []
    @num_items = 0
    @how_much_rev = 0
    # @invoices2 = []
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
