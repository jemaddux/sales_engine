require './lib/get_csv_mod'
require './lib/searching_mod'

class Transaction
  extend GetCSV
  extend Searching

  attr_accessor :id, :created_at, :updated_at, :invoice_id, :credit_card_number,
    :credit_card_expiration_date, :result, :invoice

  def self.make_transactions(testing=false)
    transaction_file = "./data/transactions.csv"
    if testing
      transaction_file = "./test/sample/transactions.csv"
    end

    csv_array = get_csv(transaction_file)
    @list_of_transactions = []
    csv_array.each do |trans_hash|
      @list_of_transactions.push(Transaction.new(trans_hash))
    end
  end

  def self.list_of_transactions
    return @list_of_transactions
  end

  def self.successful_transactions
    find_all_by("result", "success")
  end

  def self.successful_transaction_invoice_ids
    successful_invoice_ids = []
    successful_transactions.each do |transaction|
      successful_invoice_ids << transaction
    end
    successful_invoice_ids
  end

  def self.data
    list_of_transactions
  end

  # Find By

  def self.find_by_id(match)
    find_by("id", match)
  end

  def self.find_by_created_at(match)
    find_by("created_at", match)
  end

  def self.find_by_updated_at(match)
    find_by("updated_at", match)
  end

  def self.find_by_invoice_id(match)
    find_by("invoice_id", match)
  end

  def self.find_by_credit_card_number(match)
    find_by("credit_card_number", match)
  end

  def self.find_by_credit_card_expiration_date(match)
    find_by("credit_card_expiration_date", match)
  end

  def self.find_by_result(match)
    find_by("result", match)
  end

  def self.find_by_invoice(match)
    find_by("invoice", match)
  end

  # Find All By

  def self.find_all_by_id(match)
    find_all_by("id", match)
  end

  def self.find_all_by_created_at(match)
    find_all_by("created_at", match)
  end

  def self.find_all_by_updated_at(match)
    find_all_by("updated_at", match)
  end

  def self.find_all_by_invoice_id(match)
    find_all_by("invoice_id", match)
  end

  def self.find_all_by_credit_card_number(match)
    find_all_by("credit_card_number", match)
  end

  def self.find_all_by_credit_card_expiration_date(match)
    find_all_by("credit_card_expiration_date", match)
  end

  def self.find_all_by_result(match)
    find_all_by("result", match)
  end

  def self.find_all_by_invoice(match)
    find_all_by("invoice", match)
  end

  # Invoice returns an instance of invoice associated with this object

  def invoice
    Invoice.find_by_id(@invoice_id)
  end

  # Initialize

  def initialize(input)#takes in a hash
    @id = input[:id]
    @created_at = input[:created_at]
    @updated_at = input[:updated_at]
    @invoice_id = input[:invoice_id]
    @credit_card_number = input[:credit_card_number]
    @credit_card_expiration_date = input[:credit_card_expiration_date]
    @result = input[:result]
    @invoice = Invoice.new({})
  end
end
