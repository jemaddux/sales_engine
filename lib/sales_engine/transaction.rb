require 'sales_engine/get_csv_mod'
require 'sales_engine/searching_mod'

module SalesEngine
  class Transaction
    extend GetCSV
    extend Searching

    attr_accessor :id,
                  :created_at,
                  :updated_at,
                  :invoice_id,
                  :credit_card_number,
                  :credit_card_expiration_date,
                  :result,
                  :invoice

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
      @list_of_transactions.each do |transaction|
        if transaction.result == "failed"
          transaction.invoice_id = "XX"
        end
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

    def self.current_time
      time = Time.now.utc
      time.to_s
    end

    def self.new_transaction_id
      last_transaction = @list_of_transactions[-1]
      last_transaction_id = last_transaction.id
      new_transaction_id = last_transaction_id.to_i + 1
      new_transaction_id.to_s
    end

    def self.add_transaction(input)
      transaction_data = {
        :id => new_transaction_id,
        :invoice_id => input[:invoice_id],
        :credit_card_number => input[:credit_card_number],
        :credit_card_expiration_date => input[:credit_card_expiration],
        :result => input[:result],
        :created_at => current_time,
        :updated_at => current_time
      }
      new_transaction = Transaction.new(transaction_data)
      @list_of_transactions << new_transaction
    end

    # Initialize

    def initialize(input)#takes in a hash
      @id = input[:id].to_i
      @created_at = input[:created_at]
      @updated_at = input[:updated_at]
      @invoice_id = input[:invoice_id].to_i
      @credit_card_number = input[:credit_card_number]
      @credit_card_expiration_date = input[:credit_card_expiration_date]
      @result = input[:result]
    end
  end
end
