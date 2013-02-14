require './lib/get_csv_mod'

class Transaction
extend GetCSV

  attr_accessor :id, :created_at, :updated_at, :invoice_id, :credit_card_number,
    :credit_card_expiration_date, :result

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

  def initialize(input)#takes in a hash
    @id = input[:id]
    @created_at = input[:created_at]
    @updated_at = input[:updated_at]
    @invoice_id = input[:invoice_id]
    @credit_card_number = input[:credit_card_number]
    @credit_card_expiration_date = input[:credit_card_expiration_date]
    @result = input[:result]
  end
end

